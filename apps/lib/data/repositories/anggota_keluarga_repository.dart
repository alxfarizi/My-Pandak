//anggota_keluarga_repository.dart - CETAK INTEGRATION
import '../models/anggota_keluarga.dart';
import '../models/keluarga.dart';
import '../../services/supabase_service.dart';
import 'base_repository.dart';

class AnggotaKeluargaRepository implements BaseRepository<AnggotaKeluarga> {
  static const String _tableName = 'anggota_keluarga';

  @override
  Future<List<AnggotaKeluarga>> getAll() async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(nama_kepala_keluarga, rt, rw),
      desa_wisma:keluarga(desa_wisma:desa_wisma_id(nama_desa))
      ''',
        orderBy: 'created_at',
        ascending: false,
      );

      return data.map((json) => AnggotaKeluarga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch anggota keluarga: $e');
    }
  }

  // ADDED: Get all anggota with keluarga data for cetak functionality
  Future<List<Map<String, dynamic>>> getAllWithKeluargaData() async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(
        *,
        desa_wisma:desa_wisma_id(nama_desa)
      )
      ''',
        orderBy: 'created_at',
        ascending: false,
      );

      return data.map((item) {
        return {
          'anggota': AnggotaKeluarga.fromJson(item),
          'keluarga': item['keluarga'],
          'desa_wisma': item['keluarga']?['desa_wisma'],
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch anggota with keluarga data: $e');
    }
  }

  @override
  Future<AnggotaKeluarga?> getById(int id) async {
    try {
      final data = await SupabaseService.select(
        _tableName,
        filters: {'id': id},
      );

      if (data.isEmpty) return null;
      return AnggotaKeluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch anggota keluarga by id: $e');
    }
  }

  // Get anggota with keluarga data
  Future<AnggotaKeluarga?> getByIdWithKeluarga(int id) async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      keluarga:keluarga_id(*)
      ''',
        filters: {'id': id},
      );

      if (data.isEmpty) return null;
      return AnggotaKeluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch anggota with keluarga: $e');
    }
  }

  @override
  Future<AnggotaKeluarga?> create(AnggotaKeluarga entity) async {
    try {
      final data = await SupabaseService.insert(_tableName, entity.toJson());

      // Update keluarga statistics after creating anggota
      await _updateKeluargaStatistics(entity.keluargaId);

      return AnggotaKeluarga.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create anggota keluarga: $e');
    }
  }

  @override
  Future<AnggotaKeluarga?> update(int id, AnggotaKeluarga entity) async {
    try {
      // Get old data to check if keluarga_id changed
      final oldData = await getById(id);

      final data = await SupabaseService.update(
        _tableName,
        id,
        entity.toJson(),
      );

      // Update statistics for both old and new keluarga if changed
      if (oldData != null && oldData.keluargaId != entity.keluargaId) {
        await _updateKeluargaStatistics(oldData.keluargaId);
      }
      await _updateKeluargaStatistics(entity.keluargaId);

      return AnggotaKeluarga.fromJson(data);
    } catch (e) {
      throw Exception('Failed to update anggota keluarga: $e');
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      // Get anggota data before deletion to update keluarga statistics
      final anggota = await getById(id);

      await SupabaseService.deleteRecord(_tableName, id);

      // Update keluarga statistics after deletion
      if (anggota != null) {
        await _updateKeluargaStatistics(anggota.keluargaId);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // Custom methods specific to AnggotaKeluarga
  Future<List<AnggotaKeluarga>> getByKeluargaId(int keluargaId) async {
    try {
      final data = await SupabaseService.select(
        _tableName,
        filters: {'keluarga_id': keluargaId},
        orderBy: 'created_at',
        ascending: true,
      );

      return data.map((json) => AnggotaKeluarga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch anggota by keluarga id: $e');
    }
  }

  Future<int> countByKeluargaId(int keluargaId) async {
    try {
      return await SupabaseService.count(
        _tableName,
        filters: {'keluarga_id': keluargaId},
      );
    } catch (e) {
      throw Exception('Failed to count anggota by keluarga id: $e');
    }
  }

  Future<int> countByStatusPerkawinan(String status) async {
    try {
      return await SupabaseService.count(
        _tableName,
        filters: {'status_perkawinan': status},
      );
    } catch (e) {
      throw Exception('Failed to count by status perkawinan: $e');
    }
  }

  // Batch create anggota for a keluarga
  Future<List<AnggotaKeluarga>> createBatch(
    List<AnggotaKeluarga> anggotaList,
  ) async {
    try {
      final results = <AnggotaKeluarga>[];

      for (final anggota in anggotaList) {
        if (anggota.nama.trim().isNotEmpty) {
          final data = await SupabaseService.insert(
            _tableName,
            anggota.toJson(),
          );
          results.add(AnggotaKeluarga.fromJson(data));
        }
      }

      // Update keluarga statistics once after all insertions
      if (results.isNotEmpty) {
        await _updateKeluargaStatistics(results.first.keluargaId);
      }

      return results;
    } catch (e) {
      throw Exception('Failed to create batch anggota: $e');
    }
  }

  // Private method to update keluarga statistics
  Future<void> _updateKeluargaStatistics(int keluargaId) async {
    try {
      // Get all anggota for this keluarga
      final anggotaData = await SupabaseService.select(
        _tableName,
        filters: {'keluarga_id': keluargaId},
      );

      // Calculate statistics
      int totalAnggota = anggotaData.length;
      int totalLaki = anggotaData
          .where((a) => a['jenis_kelamin'] == 'L')
          .length;
      int totalPerempuan = anggotaData
          .where((a) => a['jenis_kelamin'] == 'P')
          .length;
      int totalBalita = anggotaData.where((a) {
        final umur = a['umur'] as int?;
        return umur != null && umur < 5;
      }).length;

      // Update keluarga statistics
      await SupabaseService.update('keluarga', keluargaId, {
        'jumlah_anggota': totalAnggota,
        'jumlah_laki': totalLaki,
        'jumlah_perempuan': totalPerempuan,
        'jumlah_balita': totalBalita,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Don't throw error for statistics update failure
      print('Warning: Failed to update keluarga statistics: $e');
    }
  }
}
