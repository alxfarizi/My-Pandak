//catatan_keluarga_controller.dart - FIXED JENIS KELAMIN HANDLING
import '../data/models/catatan_keluarga.dart';
import '../data/models/keluarga.dart';
import '../data/models/anggota_keluarga.dart';
import '../data/repositories/catatan_keluarga_repository.dart';
import '../data/repositories/keluarga_repository.dart';
import '../data/repositories/anggota_keluarga_repository.dart';
import 'base_controller.dart';

class CatatanKeluargaController extends BaseController {
  final CatatanKeluargaRepository _repository = CatatanKeluargaRepository();
  final KeluargaRepository _keluargaRepository = KeluargaRepository();
  final AnggotaKeluargaRepository _anggotaRepository =
  AnggotaKeluargaRepository();

  List<CatatanKeluarga> _catatanList = [];
  List<Map<String, dynamic>> _catatanMapList = [];
  CatatanKeluarga? _selectedCatatan;
  Keluarga? _selectedCatatanKeluarga;
  List<AnggotaKeluarga> _selectedCatatanAnggota = [];
  List<Map<String, dynamic>> _selectedCatatanAnggotaData = [];

  // FIXED: Add validation cache
  Set<int> _validAnggotaKeluargaIds = {};
  Map<int, AnggotaKeluarga> _anggotaKeluargaCache = {};

  List<CatatanKeluarga> get catatanList => _catatanList;
  List<Map<String, dynamic>> get catatanMapList => _catatanMapList;
  CatatanKeluarga? get selectedCatatan => _selectedCatatan;
  Keluarga? get selectedCatatanKeluarga => _selectedCatatanKeluarga;
  List<AnggotaKeluarga> get selectedCatatanAnggota => _selectedCatatanAnggota;
  List<Map<String, dynamic>> get selectedCatatanAnggotaData =>
      _selectedCatatanAnggotaData;

  Future<void> loadAllCatatan() async {
    try {
      final result = await handleAsync(_repository.getAll());
      _catatanList = result;
      notifyListeners();
    } catch (e) {
      // Error sudah di-handle di handleAsync
    }
  }

  Future<void> loadAllCatatanAsMap() async {
    try {
      final result = await handleAsync(_repository.getAllAsMap());
      _catatanMapList = result;
      notifyListeners();
    } catch (e) {
      // Error sudah di-handle di handleAsync
    }
  }

  // FIXED: Load and cache anggota keluarga data for validation
  Future<void> _loadAnggotaKeluargaCache() async {
    try {
      final allAnggota = await _anggotaRepository.getAll();
      _validAnggotaKeluargaIds = allAnggota.map((a) => a.id!).toSet();
      _anggotaKeluargaCache = {
        for (var anggota in allAnggota) anggota.id!: anggota,
      };
    } catch (e) {
      // If loading fails, clear cache to be safe
      _validAnggotaKeluargaIds.clear();
      _anggotaKeluargaCache.clear();
    }
  }

  Future<CatatanKeluarga?> getCatatanById(int id) async {
    return await handleAsyncNullable(_repository.getById(id));
  }

  Future<CatatanKeluarga?> getCatatanByIdWithFullData(int id) async {
    try {
      setLoading(true);
      clearError();

      // FIXED: Load cache first
      await _loadAnggotaKeluargaCache();

      final fullData = await _repository.getByIdWithFullData(id);
      if (fullData == null) {
        throw Exception('Catatan not found');
      }

      final catatanData = fullData['catatan'] as Map<String, dynamic>;
      final anggotaListData =
      fullData['anggota_list'] as List<Map<String, dynamic>>;

      _selectedCatatan = CatatanKeluarga.fromJson(catatanData);

      // Extract keluarga data from catatan
      final keluargaData = catatanData['keluarga'] as Map<String, dynamic>?;
      if (keluargaData != null) {
        _selectedCatatanKeluarga = Keluarga.fromJson(keluargaData);
      }

      // FIXED: Validate and sync anggota data
      _selectedCatatanAnggotaData = _validateAndSyncAnggotaData(
        anggotaListData,
      );

      notifyListeners();
      return _selectedCatatan;
    } catch (e) {
      setError('Failed to load catatan with full data: $e');
      return null;
    } finally {
      setLoading(false);
    }
  }

  // FIXED: Validate and sync anggota data with current database state
  List<Map<String, dynamic>> _validateAndSyncAnggotaData(
      List<Map<String, dynamic>> rawData,
      ) {
    final validatedData = <Map<String, dynamic>>[];

    for (int i = 0; i < rawData.length; i++) {
      final item = rawData[i];
      final anggotaId = item['id'];

      // Check if this is a valid anggota_keluarga_id
      AnggotaKeluarga? linkedAnggota;
      if (anggotaId != null && _validAnggotaKeluargaIds.contains(anggotaId)) {
        linkedAnggota = _anggotaKeluargaCache[anggotaId];
      }

      // FIXED: Handle jenis kelamin properly - convert to L/P or empty string
      String jenisKelamin = '';
      if (linkedAnggota?.jenisKelamin != null) {
        final jk = linkedAnggota!.jenisKelamin!.toUpperCase();
        if (jk == 'L' || jk == 'P') {
          jenisKelamin = jk;
        }
      }
      // If from item data
      if (jenisKelamin.isEmpty && item['jenisKelamin'] != null) {
        final jk = item['jenisKelamin'].toString().toUpperCase();
        if (jk == 'L' || jk == 'P') {
          jenisKelamin = jk;
        }
      }

      // Create validated entry
      final validatedItem = <String, dynamic>{
        'id': anggotaId ?? (10000 + i), // Use original ID or temp ID
        'no': i + 1,
        'nama': item['nama'] ?? linkedAnggota?.nama ?? '',
        'statusPerkawinan':
        item['statusPerkawinan'] ?? linkedAnggota?.statusPerkawinan ?? '',
        'jenisKelamin': jenisKelamin, // FIXED: Always valid L/P or empty
        'tempatLahir': item['tempatLahir'] ?? linkedAnggota?.tempatLahir ?? '',
        'tglBlThn':
        item['tglBlThn'] ?? _formatTanggalLahir(linkedAnggota) ?? '',
        'agama': item['agama'] ?? linkedAnggota?.agama ?? '',
        'pendidikan': item['pendidikan'] ?? linkedAnggota?.pendidikan ?? '',
        'pekerjaan': item['pekerjaan'] ?? linkedAnggota?.pekerjaan ?? '',
        'berkebutuhanKhusus': item['berkebutuhanKhusus'] ?? '',
        'penghayatanPancasila': item['penghayatanPancasila'] ?? '',
        'gotongRoyong': item['gotongRoyong'] ?? '',
        'pendidikanKeterampilan': item['pendidikanKeterampilan'] ?? '',
        'pengembanganKoperasi': item['pengembanganKoperasi'] ?? '',
        'perencanaanSehat': item['perencanaanSehat'] ?? '',
        'pangan': item['pangan'] ?? '',
        'sandang': item['sandang'] ?? '',
        'kesehatan': item['kesehatan'] ?? '',
        'ket': item['ket'] ?? '',
        // FIXED: Track if this is linked to real anggota
        'isLinkedToAnggota': linkedAnggota != null,
        'linkedAnggotaId': linkedAnggota?.id,
      };

      validatedData.add(validatedItem);
    }

    return validatedData;
  }

  String _formatTanggalLahir(AnggotaKeluarga? anggota) {
    if (anggota == null) return '';

    if (anggota.tanggalLahir != null) {
      final date = anggota.tanggalLahir!;
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }

    if (anggota.umur != null) {
      return '${anggota.umur} tahun';
    }

    return '';
  }

  Future<CatatanKeluarga?> getCatatanByKeluargaAndTahun(
      int keluargaId,
      int tahun,
      ) async {
    return await handleAsyncNullable(
      _repository.getByKeluargaAndTahun(keluargaId, tahun),
    );
  }

  Future<bool> createCatatan(CatatanKeluarga catatan) async {
    try {
      final result = await handleAsyncNullable(_repository.create(catatan));
      if (result != null) {
        _catatanList.insert(0, result);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createCatatanWithAnggotaData(
      CatatanKeluarga catatan,
      List<Map<String, dynamic>> anggotaData,
      ) async {
    try {
      setLoading(true);
      clearError();

      // FIXED: Load cache and validate data first
      await _loadAnggotaKeluargaCache();

      // Validate anggota data
      final validAnggotaData = _validateAnggotaDataForSave(anggotaData);

      if (validAnggotaData.isEmpty) {
        throw Exception(
          'Minimal harus ada satu anggota keluarga dengan nama yang diisi',
        );
      }

      final result = await _repository.createWithAnggotaData(
        catatan,
        validAnggotaData,
      );
      if (result != null) {
        _catatanList.insert(0, result);
        await loadAllCatatanAsMap();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      setError('Failed to create catatan with anggota data: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // FIXED: Validate anggota data before saving with proper jenis kelamin handling
  List<Map<String, dynamic>> _validateAnggotaDataForSave(
      List<Map<String, dynamic>> anggotaData,
      ) {
    return anggotaData
        .where(
          (anggota) => anggota['nama']?.toString().trim().isNotEmpty == true,
    )
        .map((anggota) {
      final anggotaId = anggota['id'];
      final isValidId =
          anggotaId != null &&
              anggotaId is int &&
              anggotaId < 10000 &&
              _validAnggotaKeluargaIds.contains(anggotaId);

      // FIXED: Properly handle jenis kelamin - only allow L/P or empty string
      String jenisKelamin = '';
      if (anggota['jenisKelamin'] != null) {
        final jk = anggota['jenisKelamin'].toString().toUpperCase().trim();
        if (jk == 'L' || jk == 'P') {
          jenisKelamin = jk;
        }
        // If not L or P, leave as empty string (which is allowed)
      }

      return {
        ...anggota,
        'jenisKelamin': jenisKelamin, // FIXED: Ensure valid value
        'validAnggotaKeluargaId': isValidId ? anggotaId : null,
      };
    })
        .toList();
  }

  Future<bool> updateCatatan(int id, CatatanKeluarga catatan) async {
    try {
      final result = await handleAsyncNullable(_repository.update(id, catatan));
      if (result != null) {
        final index = _catatanList.indexWhere((c) => c.id == id);
        if (index != -1) {
          _catatanList[index] = result;
        }

        if (_selectedCatatan?.id == id) {
          _selectedCatatan = result;
        }

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCatatanWithAnggotaData(
      int id,
      CatatanKeluarga catatan,
      List<Map<String, dynamic>> anggotaData,
      ) async {
    try {
      setLoading(true);
      clearError();

      // FIXED: Load cache and validate data first
      await _loadAnggotaKeluargaCache();

      // Validate anggota data
      final validAnggotaData = _validateAnggotaDataForSave(anggotaData);

      if (validAnggotaData.isEmpty) {
        throw Exception(
          'Minimal harus ada satu anggota keluarga dengan nama yang diisi',
        );
      }

      final result = await _repository.updateWithAnggotaData(
        id,
        catatan,
        validAnggotaData,
      );
      if (result != null) {
        final index = _catatanList.indexWhere((c) => c.id == id);
        if (index != -1) {
          _catatanList[index] = result;
        }

        if (_selectedCatatan?.id == id) {
          _selectedCatatan = result;
          _selectedCatatanAnggotaData = validAnggotaData;
        }

        await loadAllCatatanAsMap();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      setError('Failed to update catatan with anggota data: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> deleteCatatan(int id) async {
    return await handleAsyncBool(() async {
      final success = await _repository.delete(id);
      if (success) {
        _catatanList.removeWhere((c) => c.id == id);
        _catatanMapList.removeWhere((c) => c['id'] == id);

        if (_selectedCatatan?.id == id) {
          clearSelection();
        }

        notifyListeners();
      }
      return success;
    }());
  }

  // FIXED: Better preparation with proper sync
  Future<void> prepareCatatanForKeluarga(int keluargaId) async {
    try {
      setLoading(true);
      clearError();

      // FIXED: Load cache first
      await _loadAnggotaKeluargaCache();

      // Load keluarga data
      final keluarga = await _keluargaRepository.getById(keluargaId);
      if (keluarga == null) {
        throw Exception('Keluarga not found');
      }

      // Check if catatan already exists for current year
      final currentYear = DateTime.now().year;
      final existingCatatan = await _repository.getByKeluargaAndTahun(
        keluargaId,
        currentYear,
      );

      if (existingCatatan != null) {
        // If catatan exists, load it for editing
        await getCatatanByIdWithFullData(existingCatatan.id!);
        return;
      }

      // FIXED: Load fresh anggota data for this keluarga
      final currentAnggotaList = await _anggotaRepository.getByKeluargaId(
        keluargaId,
      );

      // Create template from current anggota data
      final anggotaTemplate = currentAnggotaList.asMap().entries.map((entry) {
        final index = entry.key;
        final anggota = entry.value;

        // FIXED: Handle jenis kelamin properly
        String jenisKelamin = '';
        if (anggota.jenisKelamin != null) {
          final jk = anggota.jenisKelamin!.toUpperCase();
          if (jk == 'L' || jk == 'P') {
            jenisKelamin = jk;
          }
        }

        return <String, dynamic>{
          'id': anggota.id!, // Use real anggota ID
          'no': index + 1,
          'nama': anggota.nama,
          'statusPerkawinan': anggota.statusPerkawinan ?? '',
          'jenisKelamin': jenisKelamin, // FIXED: Valid L/P or empty
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
          // FIXED: Mark as linked to anggota
          'isLinkedToAnggota': true,
          'linkedAnggotaId': anggota.id,
        };
      }).toList();

      _selectedCatatanKeluarga = keluarga;
      _selectedCatatanAnggotaData = anggotaTemplate;
      _selectedCatatan = null; // This is for new catatan

      notifyListeners();
    } catch (e) {
      setError('Failed to prepare catatan for keluarga: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> setSelectedCatatan(CatatanKeluarga? catatan) async {
    if (catatan?.id != null) {
      await getCatatanByIdWithFullData(catatan!.id!);
    } else {
      _selectedCatatan = catatan;
      _selectedCatatanKeluarga = null;
      _selectedCatatanAnggota.clear();
      _selectedCatatanAnggotaData.clear();
      notifyListeners();
    }
  }

  void clearSelection() {
    _selectedCatatan = null;
    _selectedCatatanKeluarga = null;
    _selectedCatatanAnggota.clear();
    _selectedCatatanAnggotaData.clear();
    notifyListeners();
  }

  void updateSelectedCatatanAnggotaData(
      List<Map<String, dynamic>> anggotaData,
      ) {
    _selectedCatatanAnggotaData = anggotaData;
    notifyListeners();
  }

  // FIXED: Better ID management to avoid foreign key violations
  void addAnggotaToSelectedCatatan() {
    // FIXED: Use timestamp-based ID to ensure uniqueness and avoid FK conflicts
    final newId = DateTime.now().millisecondsSinceEpoch;

    _selectedCatatanAnggotaData.add({
      'id': newId, // Use timestamp-based ID (will be > 10000 and unique)
      'no': _selectedCatatanAnggotaData.length + 1,
      'nama': '',
      'statusPerkawinan': '',
      'jenisKelamin': '', // FIXED: Start with empty string (valid)
      'tempatLahir': '',
      'tglBlThn': '',
      'agama': '',
      'pendidikan': '',
      'pekerjaan': '',
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
      // FIXED: Mark as not linked to anggota
      'isLinkedToAnggota': false,
      'linkedAnggotaId': null,
    });

    notifyListeners();
  }

  void removeAnggotaFromSelectedCatatan(int id) {
    _selectedCatatanAnggotaData.removeWhere((anggota) => anggota['id'] == id);

    // Renumber
    for (int i = 0; i < _selectedCatatanAnggotaData.length; i++) {
      _selectedCatatanAnggotaData[i]['no'] = i + 1;
    }

    notifyListeners();
  }

  // FIXED: Method to sync with latest keluarga data
  Future<void> syncWithKeluargaData(int keluargaId) async {
    try {
      setLoading(true);
      await _loadAnggotaKeluargaCache();

      // Get current anggota for this keluarga
      final currentAnggotaList = await _anggotaRepository.getByKeluargaId(
        keluargaId,
      );

      // Update existing data with latest anggota info
      for (final existingItem in _selectedCatatanAnggotaData) {
        final linkedId = existingItem['linkedAnggotaId'];
        if (linkedId != null) {
          final currentAnggota = currentAnggotaList.firstWhere(
                (a) => a.id == linkedId,
            orElse: () => AnggotaKeluarga(
              id: linkedId,
              keluargaId: keluargaId,
              nama: existingItem['nama'] ?? '',
            ),
          );

          // FIXED: Handle jenis kelamin properly during sync
          String jenisKelamin = '';
          if (currentAnggota.jenisKelamin != null) {
            final jk = currentAnggota.jenisKelamin!.toUpperCase();
            if (jk == 'L' || jk == 'P') {
              jenisKelamin = jk;
            }
          }

          // Update with current data but preserve catatan-specific fields
          existingItem['nama'] = currentAnggota.nama;
          existingItem['statusPerkawinan'] =
              currentAnggota.statusPerkawinan ??
                  existingItem['statusPerkawinan'];
          existingItem['jenisKelamin'] = jenisKelamin; // FIXED: Valid value
          existingItem['tempatLahir'] =
              currentAnggota.tempatLahir ?? existingItem['tempatLahir'];
          existingItem['tglBlThn'] = _formatTanggalLahir(currentAnggota);
          existingItem['agama'] = currentAnggota.agama ?? existingItem['agama'];
          existingItem['pendidikan'] =
              currentAnggota.pendidikan ?? existingItem['pendidikan'];
          existingItem['pekerjaan'] =
              currentAnggota.pekerjaan ?? existingItem['pekerjaan'];
        }
      }

      notifyListeners();
    } catch (e) {
      setError('Failed to sync with keluarga data: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> refresh() async {
    await loadAllCatatan();
  }

  Future<void> refreshAsMap() async {
    await loadAllCatatanAsMap();
  }

  Future<void> refreshSelectedCatatan() async {
    if (_selectedCatatan?.id != null) {
      await getCatatanByIdWithFullData(_selectedCatatan!.id!);
    }
  }
}
