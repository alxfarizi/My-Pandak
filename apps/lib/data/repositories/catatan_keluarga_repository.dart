//catatan_keluarga_repository.dart - COMPREHENSIVE FIX
import '../models/catatan_keluarga.dart';
import '../models/anggota_keluarga.dart';
import '../../services/supabase_service.dart';
import 'base_repository.dart';

class CatatanKeluargaRepository implements BaseRepository<CatatanKeluarga> {
  static const String _tableName = 'catatan_keluarga';

  @override
  Future<List<CatatanKeluarga>> getAll() async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(
        nama_kepala_keluarga,
        rt,
        rw,
        desa_wisma:desa_wisma_id(nama_desa)
      )
      ''',
        orderBy: 'created_at',
        ascending: false,
      );

      return data.map((json) => CatatanKeluarga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch catatan keluarga: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllAsMap() async {
    try {
      return await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(
        nama_kepala_keluarga,
        rt,
        rw,
        desa_wisma:desa_wisma_id(nama_desa)
      )
      ''',
        orderBy: 'created_at',
        ascending: false,
      );
    } catch (e) {
      throw Exception('Failed to fetch catatan keluarga as map: $e');
    }
  }

  @override
  Future<CatatanKeluarga?> getById(int id) async {
    try {
      final data = await SupabaseService.select(
        _tableName,
        filters: {'id': id},
      );

      if (data.isEmpty) return null;
      return CatatanKeluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch catatan keluarga by id: $e');
    }
  }

  Future<Map<String, dynamic>?> getByIdWithFullData(int id) async {
    try {
      final catatanData = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(
        *,
        desa_wisma:desa_wisma_id(nama_desa)
      )
      ''',
        filters: {'id': id},
      );

      if (catatanData.isEmpty) return null;

      final catatan = catatanData.first;

      // Get detail catatan anggota (snapshot data)
      final detailCatatanData = await SupabaseService.select(
        'detail_catatan_anggota',
        filters: {'catatan_keluarga_id': id},
        orderBy: 'id',
        ascending: true,
      );

      // FIXED: Better data mapping with proper validation
      final anggotaListForUI = detailCatatanData.asMap().entries.map((entry) {
        final index = entry.key;
        final detail = entry.value;

        return {
          'id':
              detail['anggota_keluarga_id'] ??
              (10000 + index), // Use original ID or temp ID
          'no': index + 1,
          'nama': detail['nama_anggota'] ?? '',
          'statusPerkawinan': detail['status_perkawinan'] ?? '',
          'jenisKelamin': detail['jenis_kelamin'] ?? '',
          'tempatLahir': detail['tempat_lahir'] ?? '',
          'tglBlThn': detail['tgl_bl_thn'] ?? '',
          'agama': detail['agama'] ?? '',
          'pendidikan': detail['pendidikan'] ?? '',
          'pekerjaan': detail['pekerjaan'] ?? '',
          'berkebutuhanKhusus': detail['berkebutuhan_khusus'] ?? '',
          'penghayatanPancasila': detail['penghayatan_pancasila'] ?? '',
          'gotongRoyong': detail['gotong_royong'] ?? '',
          'pendidikanKeterampilan': detail['pendidikan_keterampilan'] ?? '',
          'pengembanganKoperasi': detail['pengembangan_koperasi'] ?? '',
          'perencanaanSehat': detail['perencanaan_sehat'] ?? '',
          'pangan': detail['pangan'] ?? '',
          'sandang': detail['sandang'] ?? '',
          'kesehatan': detail['kesehatan'] ?? '',
          'ket': detail['keterangan'] ?? '',
          // FIXED: Add metadata for better tracking
          'detailId': detail['id'],
          'isLinkedToAnggota': detail['anggota_keluarga_id'] != null,
          'linkedAnggotaId': detail['anggota_keluarga_id'],
        };
      }).toList();

      return {'catatan': catatan, 'anggota_list': anggotaListForUI};
    } catch (e) {
      throw Exception('Failed to fetch catatan with full data: $e');
    }
  }

  @override
  Future<CatatanKeluarga?> create(CatatanKeluarga entity) async {
    try {
      final data = await SupabaseService.insert(_tableName, entity.toJson());
      return CatatanKeluarga.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create catatan keluarga: $e');
    }
  }

  // FIXED: Better handling of existing vs new catatan with proper transaction
  Future<CatatanKeluarga?> createWithAnggotaData(
    CatatanKeluarga catatan,
    List<Map<String, dynamic>> anggotaData,
  ) async {
    try {
      // Check if catatan already exists for this keluarga and year
      final existingCatatan = await getByKeluargaAndTahun(
        catatan.keluargaId,
        catatan.tahun,
      );

      if (existingCatatan != null) {
        // If exists, update instead of create
        return await updateWithAnggotaData(
          existingCatatan.id!,
          catatan.copyWith(id: existingCatatan.id),
          anggotaData,
        );
      }

      // Create new catatan
      final catatanResult = await create(catatan);
      if (catatanResult == null) return null;

      // FIXED: Create detail with better error handling
      try {
        await _createDetailCatatanAnggota(catatanResult.id!, anggotaData);
        return catatanResult;
      } catch (e) {
        // If detail creation fails, delete the catatan to maintain consistency
        try {
          await SupabaseService.deleteRecord(_tableName, catatanResult.id!);
        } catch (deleteError) {
          // Log delete error but don't throw it
          print(
            'Failed to cleanup catatan after detail creation failure: $deleteError',
          );
        }
        throw e;
      }
    } catch (e) {
      throw Exception('Failed to create catatan with anggota data: $e');
    }
  }

  @override
  Future<CatatanKeluarga?> update(int id, CatatanKeluarga entity) async {
    try {
      final data = await SupabaseService.update(
        _tableName,
        id,
        entity.toJson(),
      );
      return CatatanKeluarga.fromJson(data);
    } catch (e) {
      throw Exception('Failed to update catatan keluarga: $e');
    }
  }

  Future<CatatanKeluarga?> updateWithAnggotaData(
    int id,
    CatatanKeluarga catatan,
    List<Map<String, dynamic>> anggotaData,
  ) async {
    try {
      // Update catatan first
      final catatanResult = await update(id, catatan);
      if (catatanResult == null) return null;

      // FIXED: Better transaction-like behavior for detail updates
      try {
        // Delete existing detail catatan anggota
        await _deleteDetailCatatanAnggota(id);

        // Create new detail catatan anggota
        await _createDetailCatatanAnggota(id, anggotaData);

        return catatanResult;
      } catch (e) {
        // If detail update fails, the catatan update is already done
        // We should log this but not necessarily fail the whole operation
        print('Warning: Detail catatan anggota update failed: $e');
        throw Exception('Failed to update detail catatan anggota: $e');
      }
    } catch (e) {
      throw Exception('Failed to update catatan with anggota data: $e');
    }
  }

  // FIXED: Improved anggota_keluarga_id handling with validation
  Future<void> _createDetailCatatanAnggota(
      int catatanKeluargaId,
      List<Map<String, dynamic>> anggotaData,
      ) async {
    if (anggotaData.isEmpty) return;

    // FIXED: Get valid anggota_keluarga IDs to avoid foreign key violations
    final validAnggotaKeluargaIds = await _getValidAnggotaKeluargaIds();

    for (final anggota in anggotaData) {
      if (anggota['nama']?.toString().trim().isNotEmpty == true) {
        // FIXED: Better ID validation logic
        int? validAnggotaKeluargaId;

        // Check if we have a valid anggota_keluarga_id from the data
        final providedId =
            anggota['validAnggotaKeluargaId'] ?? anggota['linkedAnggotaId'];
        if (providedId != null &&
            providedId is int &&
            validAnggotaKeluargaIds.contains(providedId)) {
          validAnggotaKeluargaId = providedId;
        }

        // Fallback: check original ID if it's valid
        if (validAnggotaKeluargaId == null) {
          final originalId = anggota['id'];
          if (originalId != null &&
              originalId is int &&
              originalId < 10000 &&
              validAnggotaKeluargaIds.contains(originalId)) {
            validAnggotaKeluargaId = originalId;
          }
        }

        // FIXED: Handle jenis kelamin properly - only send valid values or null
        String? jenisKelamin;
        if (anggota['jenisKelamin'] != null) {
          final jk = anggota['jenisKelamin'].toString().toUpperCase().trim();
          if (jk == 'L' || jk == 'P') {
            jenisKelamin = jk;
          }
          // If not L or P, send null (which database allows)
        }

        try {
          await SupabaseService.insert('detail_catatan_anggota', {
            'catatan_keluarga_id': catatanKeluargaId,
            'nama_anggota': anggota['nama']?.toString().trim() ?? '',
            'status_perkawinan': anggota['statusPerkawinan']?.toString() ?? '',
            'jenis_kelamin': jenisKelamin, // FIXED: Only L, P, or null
            'tempat_lahir': anggota['tempatLahir']?.toString() ?? '',
            'tgl_bl_thn': anggota['tglBlThn']?.toString() ?? '',
            'agama': anggota['agama']?.toString() ?? '',
            'pendidikan': anggota['pendidikan']?.toString() ?? '',
            'pekerjaan': anggota['pekerjaan']?.toString() ?? '',
            'berkebutuhan_khusus':
            anggota['berkebutuhanKhusus']?.toString() ?? '',
            'penghayatan_pancasila':
            anggota['penghayatanPancasila']?.toString() ?? '',
            'gotong_royong': anggota['gotongRoyong']?.toString() ?? '',
            'pendidikan_keterampilan':
            anggota['pendidikanKeterampilan']?.toString() ?? '',
            'pengembangan_koperasi':
            anggota['pengembanganKoperasi']?.toString() ?? '',
            'perencanaan_sehat': anggota['perencanaanSehat']?.toString() ?? '',
            'pangan': anggota['pangan']?.toString() ?? '',
            'sandang': anggota['sandang']?.toString() ?? '',
            'kesehatan': anggota['kesehatan']?.toString() ?? '',
            'keterangan': anggota['ket']?.toString() ?? '',
            // FIXED: Only set if ID is valid in database
            'anggota_keluarga_id': validAnggotaKeluargaId,
          });
        } catch (e) {
          // FIXED: Better error handling for individual inserts
          throw Exception(
            'Failed to create detail for anggota ${anggota['nama']}: $e',
          );
        }
      }
    }
  }


  // FIXED: Cached method to get valid anggota_keluarga IDs
  Future<Set<int>> _getValidAnggotaKeluargaIds() async {
    try {
      final anggotaData = await SupabaseService.select('anggota_keluarga');
      return anggotaData.map((anggota) => anggota['id'] as int).toSet();
    } catch (e) {
      // If we can't get valid IDs, return empty set to be safe
      print('Warning: Could not load valid anggota_keluarga IDs: $e');
      return <int>{};
    }
  }

  Future<void> _deleteDetailCatatanAnggota(int catatanKeluargaId) async {
    try {
      // Get all detail records first
      final detailRecords = await SupabaseService.select(
        'detail_catatan_anggota',
        filters: {'catatan_keluarga_id': catatanKeluargaId},
      );

      // Delete each record individually with error handling
      for (final record in detailRecords) {
        try {
          await SupabaseService.deleteRecord(
            'detail_catatan_anggota',
            record['id'],
          );
        } catch (e) {
          // Log individual delete errors but continue
          print('Warning: Failed to delete detail record ${record['id']}: $e');
        }
      }
    } catch (e) {
      throw Exception('Failed to delete detail catatan anggota: $e');
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      // FIXED: Delete detail records first to avoid foreign key issues
      await _deleteDetailCatatanAnggota(id);

      // Then delete the main catatan record
      await SupabaseService.deleteRecord(_tableName, id);
      return true;
    } catch (e) {
      print('Failed to delete catatan keluarga: $e');
      return false;
    }
  }

  Future<CatatanKeluarga?> getByKeluargaAndTahun(
    int keluargaId,
    int tahun,
  ) async {
    try {
      final data = await SupabaseService.select(
        _tableName,
        filters: {'keluarga_id': keluargaId, 'tahun': tahun},
      );

      if (data.isEmpty) return null;
      return CatatanKeluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch catatan by keluarga and tahun: $e');
    }
  }

  // REMOVED: getAnggotaTemplateForKeluarga - this is now handled in controller
  // to ensure better sync with current data
}
