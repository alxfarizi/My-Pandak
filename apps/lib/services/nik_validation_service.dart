//nik_validation_service.dart - FIXED UUID HANDLING
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class NikValidationService {
  static final _client = SupabaseConfig.client;

  // FIXED: Enhanced validation with proper UUID handling
  static Future<NikValidationResult> validateNikGlobally(
      String nik, {
        String? excludeTable,
        int? excludeId,
        String? currentUserId,
      }) async {
    try {
      if (nik.length != 16 || !RegExp(r'^\d+$').hasMatch(nik)) {
        return NikValidationResult(
          isValid: false,
          error: 'NIK harus 16 digit angka',
        );
      }

      // FIXED: Use the corrected database function
      final result = await _client.rpc(
        'check_nik_availability_with_exclude',
        params: {
          'input_nik': nik,
          'user_id': currentUserId ?? '', // FIXED: Pass empty string if null
          'exclude_table': excludeTable,
          'exclude_id': excludeId,
        },
      );

      if (result == false) {
        return NikValidationResult(
          isValid: false,
          error: 'NIK sudah digunakan',
        );
      }

      return NikValidationResult(isValid: true);
    } catch (e) {
      print('NIK validation error: $e'); // FIXED: Add logging
      return NikValidationResult(
        isValid: false,
        error: 'Error validating NIK: $e',
      );
    }
  }

  // FIXED: Check availability with exclude parameters
  static Future<bool> isNikAvailable(String nik, {
    String? currentUserId,
    String? excludeTable,
    int? excludeId,
  }) async {
    final result = await validateNikGlobally(
      nik,
      currentUserId: currentUserId,
      excludeTable: excludeTable,
      excludeId: excludeId,
    );
    return result.isValid;
  }

  // FIXED: Validate for specific user context with exclude handling
  static Future<NikValidationResult> validateNikForUser(
      String nik,
      String userId, {
        bool isUpdate = false,
        int? excludeAnggotaId,
      }) async {
    try {
      if (nik.length != 16 || !RegExp(r'^\d+$').hasMatch(nik)) {
        return NikValidationResult(
          isValid: false,
          error: 'NIK harus 16 digit angka',
        );
      }

      // FIXED: For user NIK validation with exclude
      final result = await _client.rpc(
        'check_nik_availability_with_exclude',
        params: {
          'input_nik': nik,
          'user_id': userId.isNotEmpty ? userId : '', // FIXED: Ensure non-null
          'exclude_table': isUpdate && excludeAnggotaId != null ? 'anggota_keluarga' : null,
          'exclude_id': excludeAnggotaId,
        },
      );

      if (result == false) {
        return NikValidationResult(
          isValid: false,
          error: 'NIK sudah digunakan',
        );
      }

      return NikValidationResult(isValid: true);
    } catch (e) {
      print('NIK validation for user error: $e'); // FIXED: Add logging
      return NikValidationResult(
        isValid: false,
        error: 'Error validating NIK: $e',
      );
    }
  }
}

class NikValidationResult {
  final bool isValid;
  final String? error;

  NikValidationResult({
    required this.isValid,
    this.error,
  });
}
