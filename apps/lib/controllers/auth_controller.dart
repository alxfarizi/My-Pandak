//auth_controller.dart - UPDATE REGISTER WARGA BY ADMIN METHOD
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../services/admin_auth_service.dart'; // ADD THIS IMPORT

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _userProfile;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoggedIn => AuthService.isLoggedIn;
  User? get currentUser => AuthService.currentUser;

  // Get user role
  String get userRole => _userProfile?['role'] ?? 'Warga';

  // Check permissions
  bool get isAdmin => userRole == 'Admin';
  bool get isPengurus => userRole == 'Pengurus' || isAdmin;
  bool get isWarga => userRole == 'Warga';

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  // Initialize - check if user is already logged in
  Future<void> initialize() async {
    if (isLoggedIn) {
      await loadUserProfile();
    }
  }

  // Load user profile
  Future<void> loadUserProfile() async {
    try {
      _userProfile = await AuthService.getUserProfile();
      notifyListeners();
    } catch (e) {
      _setError('Gagal memuat profil: $e');
    }
  }

  // Login
  Future<bool> login({
    required String identifier,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await AuthService.signIn(
        identifier: identifier,
        password: password,
        rememberMe: rememberMe,
      );

      if (response.user != null) {
        await loadUserProfile();
        return true;
      }

      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register (for pengurus from login page)
  Future<bool> register({
    required String nik,
    required String email,
    required String password,
    required String confirmPassword,
    required String namaLengkap,
    String role = 'Warga',
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // Validation
      if (nik.trim().isEmpty) {
        throw Exception('NIK wajib diisi');
      }

      if (email.trim().isEmpty) {
        throw Exception('Email wajib diisi');
      }

      if (password.trim().isEmpty) {
        throw Exception('Password wajib diisi');
      }

      if (namaLengkap.trim().isEmpty) {
        throw Exception('Nama lengkap wajib diisi');
      }

      if (password != confirmPassword) {
        throw Exception('Password tidak cocok');
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

      final response = await AuthService.signUp(
        nik: nik.trim(),
        email: email.trim(),
        password: password,
        namaLengkap: namaLengkap.trim(),
        role: role,
      );

      if (response.user != null) {
        await loadUserProfile();
        return true;
      }

      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register Warga
  Future<bool> registerWarga({
    required String nik,
    required String email,
    required String password,
    required String confirmPassword,
    required String namaLengkap,
  }) async {
    return await register(
      nik: nik,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      namaLengkap: namaLengkap,
      role: 'Warga',
    );
  }

  // FIXED: Register warga by admin using AdminAuthService - NO LOGOUT!
  Future<bool> registerWargaByAdmin({
    required String nik,
    required String email,
    required String password,
    required String confirmPassword,
    required String namaLengkap,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // Validation
      if (nik.trim().isEmpty) {
        throw Exception('NIK wajib diisi');
      }

      if (email.trim().isEmpty) {
        throw Exception('Email wajib diisi');
      }

      if (password.trim().isEmpty) {
        throw Exception('Password wajib diisi');
      }

      if (namaLengkap.trim().isEmpty) {
        throw Exception('Nama lengkap wajib diisi');
      }

      if (password != confirmPassword) {
        throw Exception('Password tidak cocok');
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

      // FIXED: Use AdminAuthService - this won't logout current admin!
      final success = await AdminAuthService.registerUserByAdmin(
        nik: nik.trim(),
        email: email.trim(),
        password: password,
        namaLengkap: namaLengkap.trim(),
        role: 'Warga',
      );

      return success;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register Pengurus
  Future<bool> registerPengurus({
    required String nik,
    required String email,
    required String password,
    required String confirmPassword,
    required String namaLengkap,
  }) async {
    return await register(
      nik: nik,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      namaLengkap: namaLengkap,
      role: 'Pengurus',
    );
  }

  // Logout
  Future<void> logout() async {
    try {
      _setLoading(true);
      await AuthService.signOut();
      _userProfile = null;
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Gagal logout: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    try {
      _setLoading(true);
      _clearError();

      if (updates.containsKey('nik')) {
        final newNik = updates['nik'] as String?;

        if (newNik == null || newNik.trim().isEmpty) {
          throw Exception('NIK tidak boleh kosong');
        }

        if (newNik.length != 16 || !RegExp(r'^\d+$').hasMatch(newNik)) {
          throw Exception('NIK harus 16 digit angka');
        }
      }

      if (updates.containsKey('nama_lengkap')) {
        final newNama = updates['nama_lengkap'] as String?;

        if (newNama == null || newNama.trim().isEmpty) {
          throw Exception('Nama lengkap tidak boleh kosong');
        }
      }

      final success = await AuthService.updateProfile(updates);
      if (success) {
        await loadUserProfile();
      }

      return success;
    } catch (e) {
      _setError('Gagal update profil: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Change password
  Future<bool> changePassword(String newPassword) async {
    try {
      _setLoading(true);
      _clearError();

      if (newPassword.length < 6) {
        throw Exception('Password minimal 6 karakter');
      }

      await AuthService.changePassword(newPassword);
      return true;
    } catch (e) {
      _setError('Gagal ubah password: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Get user sync status with keluarga
  Future<Map<String, dynamic>> getUserSyncStatus() async {
    try {
      return await AuthService.getNikSyncStatus();
    } catch (e) {
      return {'synced': false, 'error': e.toString()};
    }
  }

  // Sync user to anggota keluarga
  Future<bool> syncUserToAnggotaKeluarga() async {
    try {
      _setLoading(true);
      _clearError();

      final success = await AuthService.syncNikToAnggotaKeluarga();
      if (success) {
        await loadUserProfile();
      }

      return success;
    } catch (e) {
      _setError('Gagal sync data: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
