//anggota_keluarga_service.dart - FIXED AUTO DATA WARGA
import '../config/supabase_config.dart';
import '../data/models/anggota_keluarga.dart';
import '../services/nik_validation_service.dart';

class AnggotaKeluargaService {
  static final _client = SupabaseConfig.client;

  // Get all anggota by keluarga_id
  static Future<List<AnggotaKeluarga>> getAnggotaByKeluargaId(int keluargaId) async {
    try {
      final response = await _client
          .from('anggota_keluarga')
          .select()
          .eq('keluarga_id', keluargaId)
          .order('created_at', ascending: true);

      return (response as List)
          .map((json) => AnggotaKeluarga.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error fetching anggota: $e');
    }
  }

  // FIXED: Get all anggota (untuk data warga page) - ini adalah data warga
  static Future<List<AnggotaKeluarga>> getAllAnggota() async {
    try {
      final response = await _client
          .from('anggota_keluarga')
          .select('''
            *,
            keluarga:keluarga_id(nama_kepala_keluarga, rt, rw),
            desa_wisma:keluarga(desa_wisma:desa_wisma_id(nama_desa))
          ''')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => AnggotaKeluarga.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error fetching all anggota: $e');
    }
  }

  // FIXED: Create anggota with enhanced NIK validation and auto data warga
  static Future<AnggotaKeluarga?> createAnggota(AnggotaKeluarga anggota) async {
    try {
      // FIXED: Enhanced NIK validation with user context
      if (anggota.nik != null && anggota.nik!.trim().isNotEmpty) {
        final currentUser = _client.auth.currentUser;
        final nikValidation = await NikValidationService.validateNikForUser(
          anggota.nik!.trim(),
          currentUser?.id ?? '',
        );
        if (!nikValidation.isValid) {
          throw Exception(nikValidation.error!);
        }
      }

      final response = await _client
          .from('anggota_keluarga')
          .insert(anggota.toJson())
          .select()
          .single();

      final createdAnggota = AnggotaKeluarga.fromJson(response);

      // FIXED: Auto-create data warga entry - anggota_keluarga IS data warga
      // No additional action needed since anggota_keluarga table serves as data warga

      return createdAnggota;
    } catch (e) {
      throw Exception('Error creating anggota: $e');
    }
  }

  // FIXED: Update anggota with proper NIK validation for edit mode
  static Future<AnggotaKeluarga?> updateAnggota(int id, AnggotaKeluarga anggota) async {
    try {
      // FIXED: Enhanced NIK validation for updates with exclude ID
      if (anggota.nik != null && anggota.nik!.trim().isNotEmpty) {
        final currentUser = _client.auth.currentUser;
        final nikValidation = await NikValidationService.validateNikForUser(
          anggota.nik!.trim(),
          currentUser?.id ?? '',
          isUpdate: true,
          excludeAnggotaId: id, // FIXED: Exclude current anggota ID
        );

        if (!nikValidation.isValid) {
          throw Exception(nikValidation.error!);
        }
      }

      final response = await _client
          .from('anggota_keluarga')
          .update(anggota.toJson())
          .eq('id', id)
          .select()
          .single();

      return AnggotaKeluarga.fromJson(response);
    } catch (e) {
      throw Exception('Error updating anggota: $e');
    }
  }

  // Delete anggota
  static Future<bool> deleteAnggota(int id) async {
    try {
      await _client
          .from('anggota_keluarga')
          .delete()
          .eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }

  // FIXED: Create batch anggota with proper NIK validation
  static Future<List<AnggotaKeluarga>> createBatchAnggota(
      List<AnggotaKeluarga> anggotaList,
      ) async {
    try {
      final results = <AnggotaKeluarga>[];
      final currentUser = _client.auth.currentUser;

      for (final anggota in anggotaList) {
        if (anggota.nama.trim().isEmpty) continue;

        // Validate NIK if provided
        if (anggota.nik != null && anggota.nik!.trim().isNotEmpty) {
          final nikValidation = await NikValidationService.validateNikForUser(
            anggota.nik!.trim(),
            currentUser?.id ?? '',
          );
          if (!nikValidation.isValid) {
            throw Exception('NIK ${anggota.nik}: ${nikValidation.error}');
          }
        }

        final response = await _client
            .from('anggota_keluarga')
            .insert(anggota.toJson())
            .select()
            .single();

        results.add(AnggotaKeluarga.fromJson(response));
      }

      return results;
    } catch (e) {
      throw Exception('Error creating batch anggota: $e');
    }
  }

  // FIXED: Ensure user exists as anggota in their keluarga
  static Future<bool> ensureUserAsAnggotaInKeluarga(int keluargaId) async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) return false;

      // Get user profile
      final userProfile = await _client
          .from('users')
          .select('nik, nama_lengkap')
          .eq('auth_id', currentUser.id)
          .single();

      final userNik = userProfile['nik'];
      final userName = userProfile['nama_lengkap'];

      if (userNik == null || userName == null) return false;

      // Check if user already exists as anggota in this keluarga
      final existingAnggota = await _client
          .from('anggota_keluarga')
          .select('id')
          .eq('keluarga_id', keluargaId)
          .eq('nik', userNik)
          .maybeSingle();

      if (existingAnggota == null) {
        // Create anggota entry for user
        await _client.from('anggota_keluarga').insert({
          'keluarga_id': keluargaId,
          'nik': userNik,
          'nama': userName,
          'status_dalam_keluarga': 'Kepala Keluarga',
          'created_by_user': currentUser.id,
        });
        return true;
      }

      return true;
    } catch (e) {
      print('Error ensuring user as anggota: $e');
      return false;
    }
  }
}
