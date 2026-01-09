//dashboard_controller.dart - ENHANCED WITH USER SYNC
import 'package:flutter/material.dart';
import '../data/repositories/anggota_keluarga_repository.dart';
import '../data/repositories/keluarga_repository.dart';
import '../services/auth_service.dart';

class DashboardController extends ChangeNotifier {
  final AnggotaKeluargaRepository _anggotaRepository = AnggotaKeluargaRepository();
  final KeluargaRepository _keluargaRepository = KeluargaRepository();

  bool _isLoading = false;
  String? _error;

  // Dashboard stats
  int _totalAnggota = 0;
  int _totalKeluarga = 0;
  int _totalMenikah = 0;
  int _totalBelumMenikah = 0;

  // FIXED: User sync status
  Map<String, dynamic> _userSyncStatus = {};

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalAnggota => _totalAnggota;
  int get totalKeluarga => _totalKeluarga;
  int get totalMenikah => _totalMenikah;
  int get totalBelumMenikah => _totalBelumMenikah;
  Map<String, dynamic> get userSyncStatus => _userSyncStatus; // FIXED: Added getter

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

  // FIXED: Enhanced dashboard stats loading with user sync status
  Future<void> loadDashboardStats() async {
    try {
      _setLoading(true);
      _clearError();

      // Load basic stats
      await Future.wait([
        _loadAnggotaStats(),
        _loadKeluargaStats(),
        _loadUserSyncStatus(), // FIXED: Added user sync status
      ]);

    } catch (e) {
      _setError('Gagal memuat data dashboard: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadAnggotaStats() async {
    try {
      final allAnggota = await _anggotaRepository.getAll();
      _totalAnggota = allAnggota.length;

      // Count by status perkawinan
      _totalMenikah = allAnggota
          .where((a) => a.statusPerkawinan?.toLowerCase().contains('menikah') == true)
          .length;

      _totalBelumMenikah = allAnggota
          .where((a) =>
      a.statusPerkawinan?.toLowerCase().contains('lajang') == true ||
          a.statusPerkawinan?.toLowerCase().contains('belum') == true)
          .length;
    } catch (e) {
      print('Error loading anggota stats: $e');
    }
  }

  Future<void> _loadKeluargaStats() async {
    try {
      final allKeluarga = await _keluargaRepository.getAll();
      _totalKeluarga = allKeluarga.length;
    } catch (e) {
      print('Error loading keluarga stats: $e');
    }
  }

  // FIXED: Load user sync status
  Future<void> _loadUserSyncStatus() async {
    try {
      if (AuthService.isLoggedIn) {
        _userSyncStatus = await AuthService.getNikSyncStatus();
      } else {
        _userSyncStatus = {'synced': false};
      }
    } catch (e) {
      print('Error loading user sync status: $e');
      _userSyncStatus = {'synced': false, 'error': e.toString()};
    }
  }

  // FIXED: Method to sync user data
  Future<bool> syncUserData() async {
    try {
      _setLoading(true);
      _clearError();

      final success = await AuthService.syncNikToAnggotaKeluarga();

      if (success) {
        // Refresh sync status and dashboard stats
        await _loadUserSyncStatus();
        await loadDashboardStats();
      }

      return success;
    } catch (e) {
      _setError('Gagal sync data user: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // FIXED: Check if user needs sync
  bool get userNeedsSync {
    final hasKeluarga = _userSyncStatus['has_keluarga'] ?? false;
    final isSynced = _userSyncStatus['synced'] ?? false;
    return hasKeluarga && !isSynced;
  }

  // FIXED: Get sync status message
  String? get syncStatusMessage {
    return _userSyncStatus['message'];
  }

  Future<void> refresh() async {
    await loadDashboardStats();
  }
}
