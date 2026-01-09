//supabase_service.dart - FIXED UPSERT METHOD
import '../config/supabase_config.dart';

class SupabaseService {
  static final _client = SupabaseConfig.client;

  static Future<List<Map<String, dynamic>>> select(
      String table, {
        String? select,
        Map<String, dynamic>? filters,
        String? orderBy,
        bool ascending = true,
        int? limit,
      }) async {
    try {
      dynamic query = _client.from(table).select(select ?? '*');

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Error selecting from $table: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> selectWithJoin(
      String table,
      String selectQuery, {
        Map<String, dynamic>? filters,
        String? orderBy,
        bool ascending = true,
        int? limit,
      }) async {
    try {
      dynamic query = _client.from(table).select(selectQuery);

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Error selecting with join from $table: $e');
    }
  }

  static Future<Map<String, dynamic>> insert(
      String table,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Error inserting to $table: $e');
    }
  }

  // FIXED: Enhanced method that auto-fills created_by_user
  static Future<Map<String, dynamic>> insertWithAuth(
      String table,
      Map<String, dynamic> data,
      ) async {
    try {
      // Auto-set created_by_user to current authenticated user
      final currentUser = _client.auth.currentUser;
      if (currentUser != null && !data.containsKey('created_by_user')) {
        data['created_by_user'] = currentUser.id;
      }

      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Error inserting to $table: $e');
    }
  }

  static Future<Map<String, dynamic>> update(
      String table,
      int id,
      Map<String, dynamic> data,
      ) async {
    try {
      // FIXED: Remove created_by_user from update data to prevent override
      final updateData = Map<String, dynamic>.from(data);
      updateData.remove('created_by_user');

      final response = await _client
          .from(table)
          .update(updateData)
          .eq('id', id)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Error updating $table: $e');
    }
  }

  static Future<void> deleteRecord(String table, int id) async {
    try {
      await _client.from(table).delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting from $table: $e');
    }
  }

  static Future<int> count(
      String table, {
        Map<String, dynamic>? filters,
      }) async {
    try {
      dynamic query = _client.from(table).select('id');

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query;
      return (response as List).length;
    } catch (e) {
      throw Exception('Error counting $table: $e');
    }
  }

  // ADDED: Batch operations with proper error handling
  static Future<List<Map<String, dynamic>>> insertBatch(
      String table,
      List<Map<String, dynamic>> dataList,
      ) async {
    try {
      final results = <Map<String, dynamic>>[];

      for (final data in dataList) {
        try {
          final result = await insert(table, data);
          results.add(result);
        } catch (e) {
          print('Warning: Failed to insert item in batch: $e');
          // Continue with other items instead of failing completely
        }
      }

      return results;
    } catch (e) {
      throw Exception('Error batch inserting into $table: $e');
    }
  }

  // ADDED: Enhanced batch with auth
  static Future<List<Map<String, dynamic>>> insertBatchWithAuth(
      String table,
      List<Map<String, dynamic>> dataList,
      ) async {
    try {
      final results = <Map<String, dynamic>>[];
      final currentUser = _client.auth.currentUser;

      for (final data in dataList) {
        try {
          // Auto-set created_by_user if not already set
          if (currentUser != null && !data.containsKey('created_by_user')) {
            data['created_by_user'] = currentUser.id;
          }

          final result = await insert(table, data);
          results.add(result);
        } catch (e) {
          print('Warning: Failed to insert item in batch: $e');
          // Continue with other items
        }
      }

      return results;
    } catch (e) {
      throw Exception('Error batch inserting with auth into $table: $e');
    }
  }

  // ADDED: Helper method for single record queries
  static Future<Map<String, dynamic>?> selectSingle(
      String table, {
        String? select,
        Map<String, dynamic>? filters,
      }) async {
    try {
      dynamic query = _client.from(table).select(select ?? '*');

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query.maybeSingle();
      return response;
    } catch (e) {
      throw Exception('Error selecting single from $table: $e');
    }
  }

  // FIXED: Simple upsert operation without onConflict
  static Future<Map<String, dynamic>> upsert(
      String table,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await _client
          .from(table)
          .upsert(data)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Error upserting to $table: $e');
    }
  }

  // FIXED: Enhanced upsert with auth
  static Future<Map<String, dynamic>> upsertWithAuth(
      String table,
      Map<String, dynamic> data,
      ) async {
    try {
      // Auto-set created_by_user to current authenticated user
      final currentUser = _client.auth.currentUser;
      if (currentUser != null && !data.containsKey('created_by_user')) {
        data['created_by_user'] = currentUser.id;
      }

      final response = await _client
          .from(table)
          .upsert(data)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Error upserting with auth to $table: $e');
    }
  }

  // ADDED: Bulk delete operation
  static Future<void> deleteWhere(
      String table,
      Map<String, dynamic> filters,
      ) async {
    try {
      dynamic query = _client.from(table).delete();

      filters.forEach((key, value) {
        query = query.eq(key, value);
      });

      await query;
    } catch (e) {
      throw Exception('Error bulk deleting from $table: $e');
    }
  }

  // ADDED: Check if record exists
  static Future<bool> exists(
      String table,
      Map<String, dynamic> filters,
      ) async {
    try {
      final result = await selectSingle(table, select: 'id', filters: filters);
      return result != null;
    } catch (e) {
      return false;
    }
  }

  // ADDED: Insert or update based on existence
  static Future<Map<String, dynamic>> insertOrUpdate(
      String table,
      Map<String, dynamic> data,
      Map<String, dynamic> checkFilters,
      ) async {
    try {
      final existing = await selectSingle(table, filters: checkFilters);

      if (existing != null) {
        // Update existing record
        final id = existing['id'] as int;
        return await update(table, id, data);
      } else {
        // Insert new record
        return await insert(table, data);
      }
    } catch (e) {
      throw Exception('Error insert or update to $table: $e');
    }
  }

  // ADDED: Insert or update with auth
  static Future<Map<String, dynamic>> insertOrUpdateWithAuth(
      String table,
      Map<String, dynamic> data,
      Map<String, dynamic> checkFilters,
      ) async {
    try {
      // Auto-set created_by_user to current authenticated user
      final currentUser = _client.auth.currentUser;
      if (currentUser != null && !data.containsKey('created_by_user')) {
        data['created_by_user'] = currentUser.id;
      }

      final existing = await selectSingle(table, filters: checkFilters);

      if (existing != null) {
        // Update existing record
        final id = existing['id'] as int;
        return await update(table, id, data);
      } else {
        // Insert new record
        return await insert(table, data);
      }
    } catch (e) {
      throw Exception('Error insert or update with auth to $table: $e');
    }
  }
}
