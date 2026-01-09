//catatan_keluarga_service.dart
import '../config/supabase_config.dart';
import '../data/models/catatan_keluarga.dart';

class CatatanKeluargaService {
  static final _client = SupabaseConfig.client;

  // Get all catatan keluarga with keluarga info
  static Future<List<Map<String, dynamic>>> getAllCatatanKeluarga() async {
    try {
      final response = await _client
          .from('catatan_keluarga')
          .select('''
            *,
            keluarga:keluarga_id(
              nama_kepala_keluarga,
              desa_wisma:desa_wisma_id(nama_desa)
            )
          ''')
          .order('created_at', ascending: false);

      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Error fetching catatan keluarga: $e');
    }
  }

  // Get catatan by ID
  static Future<CatatanKeluarga?> getCatatanById(int id) async {
    try {
      final response = await _client
          .from('catatan_keluarga')
          .select()
          .eq('id', id)
          .single();

      return CatatanKeluarga.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Create new catatan
  static Future<CatatanKeluarga?> createCatatan(CatatanKeluarga catatan) async {
    try {
      final response = await _client
          .from('catatan_keluarga')
          .insert(catatan.toJson())
          .select()
          .single();

      return CatatanKeluarga.fromJson(response);
    } catch (e) {
      throw Exception('Error creating catatan: $e');
    }
  }

  // Update catatan
  static Future<CatatanKeluarga?> updateCatatan(int id, CatatanKeluarga catatan) async {
    try {
      final response = await _client
          .from('catatan_keluarga')
          .update(catatan.toJson())
          .eq('id', id)
          .select()
          .single();

      return CatatanKeluarga.fromJson(response);
    } catch (e) {
      throw Exception('Error updating catatan: $e');
    }
  }


  static Future<bool> deleteCatatan(int id) async {
    try {
      await _client
          .from('catatan_keluarga')
          .delete()
          .eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get catatan by keluarga_id and tahun
  static Future<CatatanKeluarga?> getCatatanByKeluargaAndTahun(int keluargaId, int tahun) async {
    try {
      final response = await _client
          .from('catatan_keluarga')
          .select()
          .eq('keluarga_id', keluargaId)
          .eq('tahun', tahun)
          .single();

      return CatatanKeluarga.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
