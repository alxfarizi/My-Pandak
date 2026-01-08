//keluarga_repository.dart - FIXED AUTO USER SYNC
import '../models/keluarga.dart';
import '../models/anggota_keluarga.dart';
import '../../services/supabase_service.dart';
import '../../services/anggota_keluarga_service.dart';
import 'base_repository.dart';

class KeluargaRepository implements BaseRepository<Keluarga> {
  static const String _tableName = 'keluarga';

  @override
  Future<List<Keluarga>> getAll() async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      desa_wisma:desa_wisma_id(nama_desa)
      ''',
        orderBy: 'created_at',
        ascending: false,
      );

      return data.map((json) => Keluarga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch keluarga: $e');
    }
  }

  @override
  Future<Keluarga?> getById(int id) async {
    try {
      final data = await SupabaseService.select(
        _tableName,
        filters: {'id': id},
      );

      if (data.isEmpty) return null;
      return Keluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch keluarga by id: $e');
    }
  }

  Future<Keluarga?> getByIdWithAnggota(int id) async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      desa_wisma:desa_wisma_id(nama_desa),
      anggota_keluarga(*)
      ''',
        filters: {'id': id},
      );

      if (data.isEmpty) return null;
      return Keluarga.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to fetch keluarga with anggota: $e');
    }
  }

  @override
  Future<Keluarga?> create(Keluarga entity) async {
    try {
      // FIXED: Create keluarga with auto-fill created_by_user
      final data = await SupabaseService.insertWithAuth(_tableName, entity.toJson());
      final createdKeluarga = Keluarga.fromJson(data);

      // FIXED: Auto-ensure user exists as anggota in their keluarga
      if (createdKeluarga.id != null) {
        await AnggotaKeluargaService.ensureUserAsAnggotaInKeluarga(createdKeluarga.id!);
      }

      return createdKeluarga;
    } catch (e) {
      throw Exception('Failed to create keluarga: $e');
    }
  }

  @override
  Future<Keluarga?> update(int id, Keluarga entity) async {
    try {
      final data = await SupabaseService.update(_tableName, id, entity.toJson());
      return Keluarga.fromJson(data);
    } catch (e) {
      throw Exception('Failed to update keluarga: $e');
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      await SupabaseService.deleteRecord(_tableName, id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Keluarga>> getKeluargaWithStatistics() async {
    try {
      final data = await SupabaseService.selectWithJoin(
        _tableName,
        '''
      *,
      desa_wisma:desa_wisma_id(nama_desa),
      anggota_count:anggota_keluarga(count)
      ''',
        orderBy: 'created_at',
        ascending: false,
      );

      return data.map((json) => Keluarga.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch keluarga with statistics: $e');
    }
  }

  Future<bool> updateStatisticsFromAnggota(int keluargaId) async {
    try {
      final anggotaData = await SupabaseService.select(
        'anggota_keluarga',
        filters: {'keluarga_id': keluargaId},
      );

      int totalAnggota = anggotaData.length;
      int totalLaki = anggotaData.where((a) => a['jenis_kelamin'] == 'L').length;
      int totalPerempuan = anggotaData.where((a) => a['jenis_kelamin'] == 'P').length;
      int totalBalita = anggotaData.where((a) {
        final umur = a['umur'] as int?;
        return umur != null && umur < 5;
      }).length;

      await SupabaseService.update(_tableName, keluargaId, {
        'jumlah_anggota': totalAnggota,
        'jumlah_laki': totalLaki,
        'jumlah_perempuan': totalPerempuan,
        'jumlah_balita': totalBalita,
        'updated_at': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      throw Exception('Failed to update keluarga statistics: $e');
    }
  }
}
