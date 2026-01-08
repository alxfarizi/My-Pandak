//auth_service.dart - ADDED ADMIN SIGNUP
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/supabase_config.dart';
import '../services/nik_validation_service.dart';

class AuthService {
  static final _client = SupabaseConfig.client;
  static const String _rememberMeKey = 'remember_me';

  // Get current user
  static User? get currentUser => _client.auth.currentUser;

  // Check if user is logged in
  static bool get isLoggedIn => currentUser != null;

  // Check if remember me is enabled
  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  // Set remember me preference
  static Future<void> setRememberMe(bool remember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, remember);
  }

  // FIXED: Login with email/NIK and password - with temp user support
  static Future<AuthResponse> signIn({
    required String identifier,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // Save remember me preference
      await setRememberMe(rememberMe);

      // Cek apakah identifier adalah email atau NIK
      late String email;

      if (identifier.contains('@')) {
        email = identifier;
      } else {
        final response = await _client
            .from('users')
            .select('email')
            .eq('nik', identifier)
            .maybeSingle();

        if (response == null) {
          throw Exception('NIK tidak ditemukan');
        }

        email = response['email'];
      }

      // FIXED: Try normal login first
      try {
        final authResponse = await _client.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (authResponse.user != null) {
          // Update last login
          await _client
              .from('users')
              .update({'last_login': DateTime.now().toIso8601String()})
              .eq('auth_id', authResponse.user!.id);

          return authResponse;
        }
      } catch (normalLoginError) {
        // FIXED: If normal login fails, try temp user login
        print('Normal login failed, trying temp user login: $normalLoginError');

        final tempLoginSuccess = await loginTempUser(email, password);

        if (tempLoginSuccess) {
          // After successful temp login, try normal login again
          final authResponse = await _client.auth.signInWithPassword(
            email: email,
            password: password,
          );

          if (authResponse.user != null) {
            return authResponse;
          }
        }

        // If both fail, throw original error
        throw normalLoginError;
      }

      throw Exception('Login gagal');
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  // FIXED: Handle login for temp users (first time login)
  static Future<bool> loginTempUser(String email, String password) async {
    try {
      // Check if user exists in database with temp_password
      final userData = await _client
          .from('users')
          .select('*')
          .eq('email', email.trim())
          .eq('temp_password', password)
          .eq('is_active', false)
          .maybeSingle();

      if (userData == null) {
        return false; // Not a temp user or wrong credentials
      }

      print('Found temp user: ${userData['nama_lengkap']}');

      // FIXED: Create proper auth user
      final authResponse = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Gagal membuat akun authentication');
      }

      print('Created auth user: ${authResponse.user!.id}');

      // FIXED: Update user record with proper auth_id and activate
      await _client.from('users').update({
        'auth_id': authResponse.user!.id,
        'is_active': true,
        'temp_password': null, // Remove temp password
        'last_login': DateTime.now().toIso8601String(),
      }).eq('id', userData['id']);

      print('Updated user record successfully');

      return true;
    } catch (e) {
      print('Temp user login error: $e');
      return false;
    }
  }



  static Future<AuthResponse> signUp({
    required String nik,
    required String email,
    required String password,
    required String namaLengkap,
    String role = 'Warga',
  }) async {
    try {
      // Validasi input
      if (namaLengkap.trim().length < 2) {
        throw Exception('Nama lengkap minimal 2 karakter');
      }

      if (nik.length != 16 || !RegExp(r'^\d+$').hasMatch(nik)) {
        throw Exception('NIK harus 16 digit angka');
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw Exception('Format email tidak valid');
      }

      if (password.length < 6) {
        throw Exception('Password minimal 6 karakter');
      }

      // Cek NIK uniqueness di users
      final existingNikUsers = await _client
          .from('users')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikUsers != null) {
        throw Exception('NIK sudah terdaftar di users');
      }

      // Cek NIK uniqueness di anggota_keluarga
      final existingNikAnggota = await _client
          .from('anggota_keluarga')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikAnggota != null) {
        throw Exception('NIK sudah terdaftar di anggota keluarga');
      }

      // Cek email uniqueness
      final existingEmail = await _client
          .from('users')
          .select('id')
          .eq('email', email.trim())
          .maybeSingle();

      if (existingEmail != null) {
        throw Exception('Email sudah terdaftar');
      }

      // Create auth user
      final authResponse = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Gagal membuat akun authentication');
      }

      // Insert user data
      final userData = {
        'auth_id': authResponse.user!.id,
        'nik': nik.trim(),
        'nama_lengkap': namaLengkap.trim(),
        'email': email.trim(),
        'role': role,
        'is_active': true,
      };

      await _client
          .from('users')
          .insert(userData);

      return authResponse;
    } catch (e) {
      rethrow;
    }
  }



  // FIXED: Simple approach - admin logout tapi registrasi berhasil
  static Future<bool> signUpByAdmin({
    required String nik,
    required String email,
    required String password,
    required String namaLengkap,
    String role = 'Warga',
  }) async {
    try {
      // Check admin authentication
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        throw Exception('Admin tidak terautentikasi');
      }

      // Validasi input
      if (namaLengkap.trim().length < 2) {
        throw Exception('Nama lengkap minimal 2 karakter');
      }

      if (nik.length != 16 || !RegExp(r'^\d+$').hasMatch(nik)) {
        throw Exception('NIK harus 16 digit angka');
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw Exception('Format email tidak valid');
      }

      if (password.length < 6) {
        throw Exception('Password minimal 6 karakter');
      }

      // Check uniqueness
      final existingNikUsers = await _client
          .from('users')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikUsers != null) {
        throw Exception('NIK sudah terdaftar');
      }

      final existingEmail = await _client
          .from('users')
          .select('id')
          .eq('email', email.trim())
          .maybeSingle();

      if (existingEmail != null) {
        throw Exception('Email sudah terdaftar');
      }

      final existingNikAnggota = await _client
          .from('anggota_keluarga')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikAnggota != null) {
        throw Exception('NIK sudah terdaftar di data keluarga');
      }

      // Create auth user (admin akan logout)
      final authResponse = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Gagal membuat akun authentication');
      }

      // Insert user data
      final userData = {
        'auth_id': authResponse.user!.id,
        'nik': nik.trim(),
        'nama_lengkap': namaLengkap.trim(),
        'email': email.trim(),
        'role': role,
        'is_active': true,
      };

      await _client.from('users').insert(userData);

      // Logout user baru
      await _client.auth.signOut();

      return true;
    } catch (e) {
      throw Exception('Gagal mendaftarkan warga: $e');
    }
  }



  // Sign out
  static Future<void> signOut() async {
    try {
      // Clear remember me preference
      await setRememberMe(false);

      // Sign out with timeout
      await _client.auth.signOut().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('Logout timeout, clearing session');
        },
      );
    } catch (e) {
      print('Logout error: $e');
      await setRememberMe(false);
    }
  }

  // Check if should auto login
  static Future<bool> shouldAutoLogin() async {
    if (!isLoggedIn) return false;

    final rememberMe = await getRememberMe();
    return rememberMe;
  }

  // Get user profile
  static Future<Map<String, dynamic>?> getUserProfile() async {
    if (!isLoggedIn) return null;

    try {
      final response = await _client
          .from('users')
          .select()
          .eq('auth_id', currentUser!.id)
          .single();

      return response;
    } catch (e) {
      return null;
    }
  }

  // FIXED: Update method updateProfile untuk menggunakan function yang tepat

  static Future<bool> updateProfile(Map<String, dynamic> updates) async {
    if (!isLoggedIn) return false;

    try {
      // FIXED: Validate all updates before applying
      if (updates.containsKey('nik')) {
        final newNik = updates['nik'] as String?;

        if (newNik == null || newNik.trim().isEmpty) {
          throw Exception('NIK tidak boleh kosong');
        }

        if (newNik.length != 16 || !RegExp(r'^\d+$').hasMatch(newNik)) {
          throw Exception('NIK harus 16 digit angka');
        }

        // FIXED: Use specific function for users table with proper UUID
        final result = await _client.rpc(
          'check_nikavailability_for_users',
          params: {
            'input_nik': newNik.trim(),
            'user_auth_id': currentUser!.id, // FIXED: Pass UUID directly
          },
        );

        if (result == false) {
          throw Exception('NIK sudah digunakan');
        }
      }

      if (updates.containsKey('nama_lengkap')) {
        final newNama = updates['nama_lengkap'] as String?;

        if (newNama == null || newNama.trim().isEmpty) {
          throw Exception('Nama lengkap tidak boleh kosong');
        }
      }

      if (updates.containsKey('email')) {
        final newEmail = updates['email'] as String?;

        if (newEmail == null || newEmail.trim().isEmpty) {
          throw Exception('Email tidak boleh kosong');
        }

        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(newEmail)) {
          throw Exception('Format email tidak valid');
        }
      }

      await _client
          .from('users')
          .update(updates)
          .eq('auth_id', currentUser!.id);

      return true;
    } catch (e) {
      throw Exception('Gagal update profil: $e');
    }
  }


  // Change password
  static Future<void> changePassword(String newPassword) async {
    if (newPassword.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }

    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  // FIXED: Enhanced getNikSyncStatus using database function
  static Future<Map<String, dynamic>> getNikSyncStatus() async {
    if (!isLoggedIn) return {'synced': false, 'count': 0};

    try {
      final result = await _client.rpc(
        'get_user_keluarga_sync_status',
        params: {'user_auth_id': currentUser!.id},
      );

      if (result.isNotEmpty) {
        final data = result.first;
        return {
          'synced': data['is_synced_as_anggota'] ?? false,
          'has_keluarga': data['has_keluarga'] ?? false,
          'keluarga_count': data['keluarga_count'] ?? 0,
          'anggota_count': data['anggota_count'] ?? 0,
          'nik': data['user_nik'],
          'nama': data['user_nama'],
          'message': _getSyncStatusMessage(data),
        };
      }

      return {'synced': false, 'count': 0, 'message': 'Data tidak ditemukan'};
    } catch (e) {
      return {'synced': false, 'count': 0, 'error': e.toString()};
    }
  }

  static String? _getSyncStatusMessage(Map<String, dynamic> data) {
    final hasKeluarga = data['has_keluarga'] ?? false;
    final isSynced = data['is_synced_as_anggota'] ?? false;

    if (!hasKeluarga) {
      return 'Belum membuat data keluarga';
    }

    if (!isSynced) {
      return 'User belum terdaftar sebagai anggota keluarga';
    }

    return null; // All good
  }

  // FIXED: Enhanced syncNikToAnggotaKeluarga using database function
  static Future<bool> syncNikToAnggotaKeluarga() async {
    if (!isLoggedIn) return false;

    try {
      final result = await _client.rpc(
        'manual_sync_user_to_anggota',
        params: {'user_auth_id': currentUser!.id},
      );

      final syncedCount = result as int;
      print('Synced user to $syncedCount keluarga as anggota');

      return syncedCount > 0;
    } catch (e) {
      throw Exception('Gagal sync NIK: $e');
    }
  }

  // FIXED: Check if user needs to be synced
  static Future<bool> needsSync() async {
    if (!isLoggedIn) return false;

    try {
      final status = await getNikSyncStatus();
      final hasKeluarga = status['has_keluarga'] ?? false;
      final isSynced = status['synced'] ?? false;

      return hasKeluarga && !isSynced;
    } catch (e) {
      return false;
    }
  }
}