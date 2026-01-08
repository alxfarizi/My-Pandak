//services/admin_auth_service.dart - BYPASS RLS VERSION
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AdminAuthService {
  static final _adminClient = SupabaseClient(
    SupabaseConfig.supabaseUrl,
    SupabaseConfig.supabaseServiceRoleKey,
  );

  /// Register new user by admin without affecting current session
  static Future<bool> registerUserByAdmin({
    required String nik,
    required String email,
    required String password,
    required String namaLengkap,
    String role = 'Warga',
  }) async {
    try {
      // Validate input
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

      // Check uniqueness using regular client (maintains current session)
      final regularClient = SupabaseConfig.client;

      final existingNikUsers = await regularClient
          .from('users')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikUsers != null) {
        throw Exception('NIK sudah terdaftar');
      }

      final existingEmail = await regularClient
          .from('users')
          .select('id')
          .eq('email', email.trim())
          .maybeSingle();

      if (existingEmail != null) {
        throw Exception('Email sudah terdaftar');
      }

      final existingNikAnggota = await regularClient
          .from('anggota_keluarga')
          .select('id')
          .eq('nik', nik.trim())
          .maybeSingle();

      if (existingNikAnggota != null) {
        throw Exception('NIK sudah terdaftar di data keluarga');
      }

      print('Starting admin user creation...');

      // Create user using Admin API
      final adminAuthResponse = await _adminClient.auth.admin.createUser(
        AdminUserAttributes(
          email: email.trim(),
          password: password,
          emailConfirm: true,
          userMetadata: {
            'nik': nik.trim(),
            'nama_lengkap': namaLengkap.trim(),
            'role': role,
          },
        ),
      );

      if (adminAuthResponse.user == null) {
        throw Exception('Gagal membuat akun authentication');
      }

      print('Auth user created: ${adminAuthResponse.user!.id}');

      // FIXED: Insert user data using ADMIN CLIENT to bypass RLS
      final userData = {
        'auth_id': adminAuthResponse.user!.id,
        'nik': nik.trim(),
        'nama_lengkap': namaLengkap.trim(),
        'email': email.trim(),
        'role': role,
        'is_active': true,
        'created_at': DateTime.now().toIso8601String(),
      };

      // Use admin client to bypass RLS
      await _adminClient.from('users').insert(userData);

      print('User data inserted successfully via admin client');
      print('Registration completed - admin session maintained!');

      return true;

    } catch (e) {
      print('Admin registration error: $e');
      throw Exception('Gagal mendaftarkan warga: $e');
    }
  }
}
