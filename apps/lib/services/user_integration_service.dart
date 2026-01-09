//user_integration_service.dart - NEW COMPREHENSIVE SERVICE
import '../config/supabase_config.dart';
import '../services/auth_service.dart';

class UserIntegrationService {
  static final _client = SupabaseConfig.client;

  // FIXED: Complete user profile validation
  static Future<Map<String, dynamic>> validateUserProfile() async {
    try {
      if (!AuthService.isLoggedIn) {
        return {
          'isValid': false,
          'missingFields': ['authentication'],
          'recommendations': ['Please login first'],
        };
      }

      final result = await _client.rpc(
        'get_user_complete_status',
        params: {'user_auth_id': AuthService.currentUser!.id},
      );

      if (result.isNotEmpty) {
        final data = result.first;
        return {
          'isValid': data['has_complete_profile'] ?? false,
          'hasKeluarga': data['has_keluarga'] ?? false,
          'isSyncedAsAnggota': data['is_synced_as_anggota'] ?? false,
          'missingFields': List<String>.from(data['missing_fields'] ?? []),
          'recommendations': List<String>.from(data['recommendations'] ?? []),
        };
      }

      return {
        'isValid': false,
        'missingFields': ['unknown'],
        'recommendations': ['Please check your profile'],
      };
    } catch (e) {
      return {
        'isValid': false,
        'error': e.toString(),
        'recommendations': ['Please try again later'],
      };
    }
  }

  // FIXED: Auto-fix user integration issues
  static Future<bool> autoFixUserIntegration() async {
    try {
      if (!AuthService.isLoggedIn) return false;

      // Get current status
      final status = await validateUserProfile();

      // If user has keluarga but not synced as anggota, sync them
      if (status['hasKeluarga'] == true && status['isSyncedAsAnggota'] == false) {
        final syncSuccess = await AuthService.syncNikToAnggotaKeluarga();
        if (!syncSuccess) {
          throw Exception('Failed to sync user as anggota');
        }
      }

      return true;
    } catch (e) {
      print('Auto-fix failed: $e');
      return false;
    }
  }

  // FIXED: Check data consistency
  static Future<Map<String, dynamic>> checkDataConsistency() async {
    try {
      final result = await _client.rpc('validate_data_consistency');

      final issues = <Map<String, dynamic>>[];
      for (final row in result) {
        if ((row['issue_count'] as int) > 0) {
          issues.add({
            'table': row['table_name'],
            'type': row['issue_type'],
            'count': row['issue_count'],
            'details': row['details'],
          });
        }
      }

      return {
        'hasIssues': issues.isNotEmpty,
        'issues': issues,
        'totalIssues': issues.length,
      };
    } catch (e) {
      return {
        'hasIssues': true,
        'error': e.toString(),
      };
    }
  }

  // FIXED: Cleanup orphaned data
  static Future<int> cleanupOrphanedData() async {
    try {
      final result = await _client.rpc('cleanup_orphaned_data');
      return result as int;
    } catch (e) {
      print('Cleanup failed: $e');
      return 0;
    }
  }

  // FIXED: Get user dashboard summary
  static Future<Map<String, dynamic>> getUserDashboardSummary() async {
    try {
      if (!AuthService.isLoggedIn) {
        return {'isLoggedIn': false};
      }

      final userProfile = await AuthService.getUserProfile();
      final syncStatus = await AuthService.getNikSyncStatus();
      final profileStatus = await validateUserProfile();

      return {
        'isLoggedIn': true,
        'userProfile': userProfile,
        'syncStatus': syncStatus,
        'profileStatus': profileStatus,
        'needsAttention': _needsUserAttention(profileStatus, syncStatus),
        'actionItems': _getActionItems(profileStatus, syncStatus),
      };
    } catch (e) {
      return {
        'isLoggedIn': true,
        'error': e.toString(),
      };
    }
  }

  static bool _needsUserAttention(Map<String, dynamic> profileStatus, Map<String, dynamic> syncStatus) {
    // User needs attention if:
    // 1. Profile is incomplete
    // 2. Has keluarga but not synced
    // 3. Has sync errors

    final profileIncomplete = profileStatus['isValid'] != true;
    final hasKeluarga = profileStatus['hasKeluarga'] == true;
    final notSynced = profileStatus['isSyncedAsAnggota'] != true;
    final hasErrors = profileStatus.containsKey('error') || syncStatus.containsKey('error');

    return profileIncomplete || (hasKeluarga && notSynced) || hasErrors;
  }

  static List<String> _getActionItems(Map<String, dynamic> profileStatus, Map<String, dynamic> syncStatus) {
    final actionItems = <String>[];

    // Add recommendations from profile status
    final recommendations = profileStatus['recommendations'] as List<dynamic>?;
    if (recommendations != null) {
      actionItems.addAll(recommendations.cast<String>());
    }

    // Add sync-specific action items
    if (syncStatus['message'] != null) {
      actionItems.add(syncStatus['message']);
    }

    return actionItems;
  }
}
