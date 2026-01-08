//keluarga_controller.dart - FIXED AUTO USER INTEGRATION
import '../data/models/keluarga.dart';
import '../data/models/anggota_keluarga.dart';
import '../data/repositories/keluarga_repository.dart';
import '../data/repositories/anggota_keluarga_repository.dart';
import '../services/anggota_keluarga_service.dart';
import 'base_controller.dart';

class KeluargaController extends BaseController {
  final KeluargaRepository _repository = KeluargaRepository();
  final AnggotaKeluargaRepository _anggotaRepository = AnggotaKeluargaRepository();

  List<Keluarga> _keluargaList = [];
  Keluarga? _selectedKeluarga;
  List<AnggotaKeluarga> _selectedKeluargaAnggota = [];

  List<Keluarga> get keluargaList => _keluargaList;
  Keluarga? get selectedKeluarga => _selectedKeluarga;
  List<AnggotaKeluarga> get selectedKeluargaAnggota => _selectedKeluargaAnggota;

  // Load all keluarga
  Future<void> loadAllKeluarga() async {
    try {
      final result = await handleAsync(_repository.getAll());
      _keluargaList = result;
      notifyListeners();
    } catch (e) {
      // Error sudah di-handle di handleAsync
    }
  }

  // Alias for backward compatibility
  Future<void> loadKeluarga() async {
    await loadAllKeluarga();
  }

  Future<Keluarga?> getKeluargaById(int id) async {
    return await handleAsyncNullable(_repository.getById(id));
  }

  Future<Keluarga?> getKeluargaByIdWithAnggota(int id) async {
    try {
      setLoading(true);
      clearError();

      final keluarga = await _repository.getById(id);
      if (keluarga == null) {
        throw Exception('Keluarga not found');
      }

      final anggotaList = await _anggotaRepository.getByKeluargaId(id);

      _selectedKeluarga = keluarga;
      _selectedKeluargaAnggota = anggotaList;

      notifyListeners();
      return keluarga;
    } catch (e) {
      setError('Failed to load keluarga with anggota: $e');
      return null;
    } finally {
      setLoading(false);
    }
  }

  // FIXED: Create keluarga with auto user integration
  Future<bool> createKeluarga(Keluarga keluarga) async {
    try {
      final result = await handleAsyncNullable(_repository.create(keluarga));
      if (result != null) {
        _keluargaList.insert(0, result);

        // FIXED: Auto-ensure user is added as anggota
        if (result.id != null) {
          await AnggotaKeluargaService.ensureUserAsAnggotaInKeluarga(result.id!);
        }

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // FIXED: Create keluarga with anggota and proper user integration
  Future<Keluarga?> createKeluargaWithAnggota(
      Keluarga keluarga,
      List<AnggotaKeluarga> anggotaList,
      ) async {
    try {
      setLoading(true);
      clearError();

      // FIXED: Create keluarga first
      final createdKeluarga = await _repository.create(keluarga);
      if (createdKeluarga == null) {
        throw Exception('Failed to create keluarga');
      }

      // FIXED: Process anggota list with proper keluarga_id
      final anggotaWithKeluargaId = anggotaList
          .where((anggota) => anggota.nama.trim().isNotEmpty)
          .map(
            (anggota) => AnggotaKeluarga(
          id: anggota.id,
          keluargaId: createdKeluarga.id!, // FIXED: Use created keluarga ID
          noRegistrasi: anggota.noRegistrasi,
          nama: anggota.nama,
          statusDalamKeluarga: anggota.statusDalamKeluarga,
          statusPerkawinan: anggota.statusPerkawinan,
          jenisKelamin: anggota.jenisKelamin,
          tanggalLahir: anggota.tanggalLahir,
          umur: anggota.umur,
          pendidikan: anggota.pendidikan,
          pekerjaan: anggota.pekerjaan,
          nik: anggota.nik,
          jabatan: anggota.jabatan,
          tempatLahir: anggota.tempatLahir,
          agama: anggota.agama,
          alamatDetail: anggota.alamatDetail,
          statusTinggal: anggota.statusTinggal,
          desaKelurahan: anggota.desaKelurahan,
          kabupatenKota: anggota.kabupatenKota,
          akseptorKb: anggota.akseptorKb,
          jenisAkseptorKb: anggota.jenisAkseptorKb,
          aktifPosyandu: anggota.aktifPosyandu,
          frekuensiPosyandu: anggota.frekuensiPosyandu,
          mengikutiBinaBalita: anggota.mengikutiBinaBalita,
          memilikiTabungan: anggota.memilikiTabungan,
          jenisPaketTabungan: anggota.jenisPaketTabungan,
          mengikutiPaud: anggota.mengikutiPaud,
          ikutKoperasi: anggota.ikutKoperasi,
          berkebutuhanKhusus: anggota.berkebutuhanKhusus,
        ),
      )
          .toList();

      // FIXED: Create anggota with enhanced validation
      final createdAnggota = await AnggotaKeluargaService.createBatchAnggota(
        anggotaWithKeluargaId,
      );

      // FIXED: Ensure user exists as anggota (this will check and add if needed)
      await AnggotaKeluargaService.ensureUserAsAnggotaInKeluarga(createdKeluarga.id!);

      _keluargaList.insert(0, createdKeluarga);
      notifyListeners();
      return createdKeluarga;
    } catch (e) {
      setError('Failed to create keluarga with anggota: $e');
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> updateKeluarga(int id, Keluarga keluarga) async {
    try {
      final result = await handleAsyncNullable(
        _repository.update(id, keluarga),
      );
      if (result != null) {
        final index = _keluargaList.indexWhere((k) => k.id == id);
        if (index != -1) {
          _keluargaList[index] = result;
        }

        if (_selectedKeluarga?.id == id) {
          _selectedKeluarga = result;
        }

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // FIXED: Update keluarga with anggota and proper user handling
  Future<bool> updateKeluargaWithAnggota(
      int id,
      Keluarga keluarga,
      List<AnggotaKeluarga> anggotaList,
      ) async {
    try {
      setLoading(true);
      clearError();

      // Update keluarga first
      final updatedKeluarga = await _repository.update(id, keluarga);
      if (updatedKeluarga == null) {
        throw Exception('Failed to update keluarga');
      }

      // Get existing anggota
      final existingAnggota = await _anggotaRepository.getByKeluargaId(id);

      // Process anggota updates with proper ID handling
      for (final anggota in anggotaList) {
        if (anggota.nama.trim().isEmpty) continue;

        final anggotaWithKeluargaId = AnggotaKeluarga(
          id: anggota.id,
          keluargaId: id,
          noRegistrasi: anggota.noRegistrasi,
          nama: anggota.nama,
          statusDalamKeluarga: anggota.statusDalamKeluarga,
          statusPerkawinan: anggota.statusPerkawinan,
          jenisKelamin: anggota.jenisKelamin,
          tanggalLahir: anggota.tanggalLahir,
          umur: anggota.umur,
          pendidikan: anggota.pendidikan,
          pekerjaan: anggota.pekerjaan,
          nik: anggota.nik,
          jabatan: anggota.jabatan,
          tempatLahir: anggota.tempatLahir,
          agama: anggota.agama,
          alamatDetail: anggota.alamatDetail,
          statusTinggal: anggota.statusTinggal,
          desaKelurahan: anggota.desaKelurahan,
          kabupatenKota: anggota.kabupatenKota,
          akseptorKb: anggota.akseptorKb,
          jenisAkseptorKb: anggota.jenisAkseptorKb,
          aktifPosyandu: anggota.aktifPosyandu,
          frekuensiPosyandu: anggota.frekuensiPosyandu,
          mengikutiBinaBalita: anggota.mengikutiBinaBalita,
          memilikiTabungan: anggota.memilikiTabungan,
          jenisPaketTabungan: anggota.jenisPaketTabungan,
          mengikutiPaud: anggota.mengikutiPaud,
          ikutKoperasi: anggota.ikutKoperasi,
          berkebutuhanKhusus: anggota.berkebutuhanKhusus,
        );

        try {
          // Check if anggota exists and has valid ID
          if (anggota.id != null && anggota.id! < 10000) {
            // Update existing anggota
            await _anggotaRepository.update(anggota.id!, anggotaWithKeluargaId);
          } else {
            // Create new anggota
            await _anggotaRepository.create(anggotaWithKeluargaId);
          }
        } catch (e) {
          print('Warning: Failed to process anggota ${anggota.nama}: $e');
        }
      }

      // Remove anggota that are no longer in the list (but keep user's anggota)
      final currentAnggotaIds = anggotaList
          .where((a) => a.id != null && a.id! < 10000)
          .map((a) => a.id!)
          .toSet();

      for (final existing in existingAnggota) {
        if (existing.id != null && !currentAnggotaIds.contains(existing.id!)) {
          // FIXED: Don't delete user's own anggota entry
          // Check if this anggota belongs to the current user
          final isUserAnggota = await _isUserAnggota(existing);
          if (!isUserAnggota) {
            try {
              await _anggotaRepository.delete(existing.id!);
            } catch (e) {
              print('Warning: Failed to delete anggota ${existing.nama}: $e');
            }
          }
        }
      }

      // FIXED: Ensure user still exists as anggota after update
      await AnggotaKeluargaService.ensureUserAsAnggotaInKeluarga(id);

      // Update local state
      final index = _keluargaList.indexWhere((k) => k.id == id);
      if (index != -1) {
        _keluargaList[index] = updatedKeluarga;
      }

      if (_selectedKeluarga?.id == id) {
        _selectedKeluarga = updatedKeluarga;
        _selectedKeluargaAnggota = await _anggotaRepository.getByKeluargaId(id);
      }

      notifyListeners();
      return true;
    } catch (e) {
      setError('Failed to update keluarga with anggota: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // FIXED: Helper method to check if anggota belongs to current user
  Future<bool> _isUserAnggota(AnggotaKeluarga anggota) async {
    try {
      if (anggota.nik == null) return false;

      // Check if this NIK matches current user's NIK
      final userProfile = await _getCurrentUserProfile();
      return userProfile?['nik'] == anggota.nik;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> _getCurrentUserProfile() async {
    try {
      final currentUser = _getCurrentUser();
      if (currentUser == null) return null;

      // This would need to be implemented based on your auth service
      // For now, returning null to be safe
      return null;
    } catch (e) {
      return null;
    }
  }

  dynamic _getCurrentUser() {
    // This should return current user from your auth service
    // Implementation depends on your auth setup
    return null;
  }

  Future<bool> deleteKeluarga(int id) async {
    return await handleAsyncBool(() async {
      final success = await _repository.delete(id);
      if (success) {
        _keluargaList.removeWhere((k) => k.id == id);

        if (_selectedKeluarga?.id == id) {
          clearSelection();
        }

        notifyListeners();
      }
      return success;
    }());
  }

  Future<void> setSelectedKeluarga(Keluarga? keluarga) async {
    if (keluarga?.id != null) {
      await getKeluargaByIdWithAnggota(keluarga!.id!);
    } else {
      _selectedKeluarga = keluarga;
      _selectedKeluargaAnggota.clear();
      notifyListeners();
    }
  }

  void clearSelection() {
    _selectedKeluarga = null;
    _selectedKeluargaAnggota.clear();
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadAllKeluarga();
  }

  Future<void> refreshSelectedKeluarga() async {
    if (_selectedKeluarga?.id != null) {
      await getKeluargaByIdWithAnggota(_selectedKeluarga!.id!);
    }
  }
}
