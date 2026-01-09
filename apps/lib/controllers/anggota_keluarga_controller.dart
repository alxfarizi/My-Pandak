//anggota_keluarga_controller.dart - MISSING METHOD FIX
import '../data/models/anggota_keluarga.dart';
import '../data/models/keluarga.dart';
import '../data/repositories/anggota_keluarga_repository.dart';
import '../data/repositories/keluarga_repository.dart';
import 'base_controller.dart';

class AnggotaKeluargaController extends BaseController {
  final AnggotaKeluargaRepository _repository = AnggotaKeluargaRepository();
  final KeluargaRepository _keluargaRepository = KeluargaRepository();

  List<AnggotaKeluarga> _anggotaList = [];
  List<AnggotaKeluarga> _anggotaByKeluarga = [];
// ADDED: For cetak data functionality
  List<Map<String, dynamic>> _anggotaWithKeluargaList = [];
  AnggotaKeluarga? _selectedAnggota;
  Keluarga? _selectedAnggotaKeluarga;

  List<AnggotaKeluarga> get anggotaList => _anggotaList;
  List<AnggotaKeluarga> get anggotaByKeluarga => _anggotaByKeluarga;
// ADDED: Getter for cetak data
  List<Map<String, dynamic>> get anggotaWithKeluargaList =>
      _anggotaWithKeluargaList;
  AnggotaKeluarga? get selectedAnggota => _selectedAnggota;
  Keluarga? get selectedAnggotaKeluarga => _selectedAnggotaKeluarga;

// Load all anggota
  Future<void> loadAllAnggota() async {
    try {
      final result = await handleAsync(_repository.getAll());
      _anggotaList = result;
      notifyListeners();
    } catch (e) {
      // Error sudah di-handle di handleAsync
    }
  }

// ADDED: Load anggota with keluarga data for cetak functionality
  Future<void> loadAllAnggotaWithKeluarga() async {
    try {
      setLoading(true);
      clearError();

      final result = await _repository.getAllWithKeluargaData();
      _anggotaWithKeluargaList = result;
      notifyListeners();
    } catch (e) {
      setError('Failed to load anggota with keluarga data: $e');
    } finally {
      setLoading(false);
    }
  }

// FIXED: Load anggota by keluarga ID with proper error handling
  Future<void> loadAnggotaByKeluarga(int keluargaId) async {
    try {
      setLoading(true);
      clearError();

      final result = await _repository.getByKeluargaId(keluargaId);
      _anggotaByKeluarga = result;
      notifyListeners();
    } catch (e) {
      setError('Failed to load anggota by keluarga: $e');
      _anggotaByKeluarga = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

// Get anggota by ID
  Future<AnggotaKeluarga?> getAnggotaById(int id) async {
    return await handleAsyncNullable(_repository.getById(id));
  }

// Get anggota by ID with keluarga data for editing
  Future<AnggotaKeluarga?> getAnggotaByIdWithKeluarga(int id) async {
    try {
      setLoading(true);
      clearError();

      // Get anggota data
      final anggota = await _repository.getById(id);
      if (anggota == null) {
        throw Exception('Anggota not found');
      }

      // Get keluarga data
      final keluarga = await _keluargaRepository.getById(anggota.keluargaId);
      if (keluarga == null) {
        throw Exception('Keluarga not found');
      }

      _selectedAnggota = anggota;
      _selectedAnggotaKeluarga = keluarga;
      notifyListeners();

      return anggota;
    } catch (e) {
      setError('Failed to load anggota with keluarga: $e');
      return null;
    } finally {
      setLoading(false);
    }
  }

// Create new anggota
  Future<bool> createAnggota(AnggotaKeluarga anggota) async {
    try {
      final result = await handleAsyncNullable(_repository.create(anggota));
      if (result != null) {
        _anggotaList.insert(0, result);
        // Also add to keluarga-specific list if it matches
        if (_anggotaByKeluarga.isNotEmpty &&
            _anggotaByKeluarga.first.keluargaId == result.keluargaId) {
          _anggotaByKeluarga.add(result);
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

// Update existing anggota
  Future<bool> updateAnggota(int id, AnggotaKeluarga anggota) async {
    try {
      final result = await handleAsyncNullable(_repository.update(id, anggota));
      if (result != null) {
        // Update in main list
        final mainIndex = _anggotaList.indexWhere((a) => a.id == id);
        if (mainIndex != -1) {
          _anggotaList[mainIndex] = result;
        }

        // Update in keluarga-specific list
        final keluargaIndex = _anggotaByKeluarga.indexWhere((a) => a.id == id);
        if (keluargaIndex != -1) {
          _anggotaByKeluarga[keluargaIndex] = result;
        }

        // Update selected anggota if it's the same
        if (_selectedAnggota?.id == id) {
          _selectedAnggota = result;
        }

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

// Delete anggota
  Future<bool> deleteAnggota(int id) async {
    return await handleAsyncBool(() async {
      final success = await _repository.delete(id);
      if (success) {
        _anggotaList.removeWhere((a) => a.id == id);
        _anggotaByKeluarga.removeWhere((a) => a.id == id);
        // ADDED: Also remove from cetak data list
        _anggotaWithKeluargaList.removeWhere(
              (item) => item['anggota']?.id == id,
        );

        // Clear selected if deleted
        if (_selectedAnggota?.id == id) {
          _selectedAnggota = null;
          _selectedAnggotaKeluarga = null;
        }

        notifyListeners();
      }
      return success;
    }());
  }

// Get count by keluarga
  Future<int> getCountByKeluarga(int keluargaId) async {
    try {
      return await handleAsync(_repository.countByKeluargaId(keluargaId));
    } catch (e) {
      return 0;
    }
  }

// Get count by status perkawinan
  Future<int> getCountByStatusPerkawinan(String status) async {
    try {
      return await handleAsync(_repository.countByStatusPerkawinan(status));
    } catch (e) {
      return 0;
    }
  }

// Set selected anggota and load its keluarga
  Future<void> setSelectedAnggota(AnggotaKeluarga? anggota) async {
    _selectedAnggota = anggota;

    if (anggota != null) {
      try {
        _selectedAnggotaKeluarga = await _keluargaRepository.getById(
          anggota.keluargaId,
        );
      } catch (e) {
        _selectedAnggotaKeluarga = null;
        setError('Failed to load keluarga for selected anggota: $e');
      }
    } else {
      _selectedAnggotaKeluarga = null;
    }

    notifyListeners();
  }

// Clear selection
  void clearSelection() {
    _selectedAnggota = null;
    _selectedAnggotaKeluarga = null;
    notifyListeners();
  }

// Get anggota template for catatan keluarga
  Future<List<Map<String, dynamic>>> getAnggotaTemplateForCatatan(
      int keluargaId,
      ) async {
    try {
      final anggotaList = await _repository.getByKeluargaId(keluargaId);

      return anggotaList.asMap().entries.map((entry) {
        final index = entry.key;
        final anggota = entry.value;

        return {
          'id': anggota.id ?? (1000 + index), // Use temp ID for new entries
          'no': index + 1,
          'nama': anggota.nama,
          'statusPerkawinan': anggota.statusPerkawinan ?? '',
          'jenisKelamin': anggota.jenisKelamin ?? '',
          'tempatLahir': anggota.tempatLahir ?? '',
          'tglBlThn': _formatTanggalLahir(anggota),
          'agama': anggota.agama ?? '',
          'pendidikan': anggota.pendidikan ?? '',
          'pekerjaan': anggota.pekerjaan ?? '',
          'berkebutuhanKhusus': '',
          'penghayatanPancasila': '',
          'gotongRoyong': '',
          'pendidikanKeterampilan': '',
          'pengembanganKoperasi': '',
          'perencanaanSehat': '',
          'pangan': '',
          'sandang': '',
          'kesehatan': '',
          'ket': '',
        };
      }).toList();
    } catch (e) {
      setError('Failed to get anggota template: $e');
      return [];
    }
  }

// Helper method to format tanggal lahir
  String _formatTanggalLahir(AnggotaKeluarga anggota) {
    if (anggota.tanggalLahir != null) {
      final date = anggota.tanggalLahir!;
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }

    if (anggota.umur != null) {
      return '${anggota.umur} tahun';
    }

    return '';
  }

// Validate anggota data
  String? validateAnggotaData(AnggotaKeluarga anggota) {
    if (anggota.nama.trim().isEmpty) {
      return 'Nama harus diisi';
    }

    if (anggota.keluargaId <= 0) {
      return 'Keluarga harus dipilih';
    }

    // Add more validation as needed
    return null;
  }

// Get anggota by keluarga for dropdown/selection
  Future<List<AnggotaKeluarga>> getAnggotaByKeluargaId(int keluargaId) async {
    try {
      return await _repository.getByKeluargaId(keluargaId);
    } catch (e) {
      setError('Failed to get anggota by keluarga: $e');
      return [];
    }
  }

// Refresh data
  Future<void> refresh() async {
    await loadAllAnggota();
  }

// ADDED: Refresh with keluarga data for cetak
  Future<void> refreshWithKeluarga() async {
    await loadAllAnggotaWithKeluarga();
  }

// Refresh keluarga-specific data
  Future<void> refreshByKeluarga(int keluargaId) async {
    await loadAnggotaByKeluarga(keluargaId);
  }

// Refresh selected anggota data
  Future<void> refreshSelectedAnggota() async {
    if (_selectedAnggota?.id != null) {
      await getAnggotaByIdWithKeluarga(_selectedAnggota!.id!);
    }
  }
}