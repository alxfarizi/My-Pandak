//keluarga_service.dart
import '../config/supabase_config.dart';
import '../data/models/keluarga.dart';

class KeluargaService {
  static final _client = SupabaseConfig.client;

  // Get all keluarga (with RLS filtering)
  static Future<List<Keluarga>> getAllKeluarga() async {
    try {
      final response = await _client
          .from('keluarga')
          .select('''
            *,
            desa_wisma:desa_wisma_id(nama_desa)
          ''')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Keluarga.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error fetching keluarga: $e');
    }
  }

  // Get keluarga by ID
  static Future<Keluarga?> getKeluargaById(int id) async {
    try {
      final response = await _client
          .from('keluarga')
          .select()
          .eq('id', id)
          .single();

      return Keluarga.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Create new keluarga - FIXED: Auto-fill created_by_user
  static Future<Keluarga?> createKeluarga(Keluarga keluarga) async {
    try {
      // FIXED: Prepare data with created_by_user
      final keluargaData = keluarga.toJson();

      // Auto-set created_by_user to current authenticated user
      final currentUser = _client.auth.currentUser;
      if (currentUser != null) {
        keluargaData['created_by_user'] = currentUser.id;
      }

      final response = await _client
          .from('keluarga')
          .insert(keluargaData)
          .select()
          .single();

      return Keluarga.fromJson(response);
    } catch (e) {
      throw Exception('Error creating keluarga: $e');
    }
  }

  // Update keluarga
  static Future<Keluarga?> updateKeluarga(int id, Keluarga keluarga) async {
    try {
      final keluargaData = keluarga.toJson();

      // FIXED: Don't override created_by_user on update
      keluargaData.remove('created_by_user');

      final response = await _client
          .from('keluarga')
          .update(keluargaData)
          .eq('id', id)
          .select()
          .single();

      return Keluarga.fromJson(response);
    } catch (e) {
      throw Exception('Error updating keluarga: $e');
    }
  }

  // Delete keluarga
  static Future<bool> deleteKeluarga(int id) async {
    try {
      await _client
          .from('keluarga')
          .delete()
          .eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
