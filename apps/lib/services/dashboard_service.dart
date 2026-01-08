//dashboard_service.dart
import '../config/supabase_config.dart';

class DashboardService {
  static final _client = SupabaseConfig.client;

  static Future<Map<String, int>> getStatistics() async {
    try {
      // Get total warga
      final wargaResponse = await _client
          .from('anggota_keluarga')
          .select('id')
          .count();

      // Get total keluarga
      final keluargaResponse = await _client
          .from('keluarga')
          .select('id')
          .count();

      // Get total menikah
      final menikahResponse = await _client
          .from('anggota_keluarga')
          .select('id')
          .eq('status_perkawinan', 'Menikah')
          .count();

      // Get total balita (umur < 5 atau null)
      final balitaResponse = await _client
          .from('anggota_keluarga')
          .select('id')
          .or('umur.lt.5,umur.is.null')
          .count();

      // Get total catatan keluarga
      final catatanResponse = await _client
          .from('catatan_keluarga')
          .select('id')
          .count();

      return {
        'totalWarga': wargaResponse.count,
        'totalKeluarga': keluargaResponse.count,
        'totalMenikah': menikahResponse.count,
        'totalBalita': balitaResponse.count,
        'totalCatatan': catatanResponse.count,
      };
    } catch (e) {
      throw Exception('Error fetching statistics: $e');
    }
  }
}
