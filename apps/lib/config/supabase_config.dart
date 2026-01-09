//supabase_config.dart - ADD SERVICE ROLE KEY
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://jyqxhiylfqzxqnrqeflq.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5cXhoaXlsZnF6eHFucnFlZmxxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYxNTIyODYsImV4cCI6MjA4MTcyODI4Nn0.RGxIre3PGHgolKebY5J-AuBjhboryGKitYNbkVTs2S8';

  // ADD THIS: Your service_role key (get from Supabase Dashboard -> Settings -> API)
  static const String supabaseServiceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5cXhoaXlsZnF6eHFucnFlZmxxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NjE1MjI4NiwiZXhwIjoyMDgxNzI4Mjg2fQ.xA_EE7nLrrRHehEkGWSTqS0FQ7FeMoHRanp2Q7jEXrs'; // TODO: Replace with actual service_role key

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
