//main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/supabase_config.dart';
import 'controllers/auth_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/keluarga_controller.dart';
import 'controllers/anggota_keluarga_controller.dart';
import 'controllers/catatan_keluarga_controller.dart';
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => KeluargaController()),
        ChangeNotifierProvider(create: (_) => AnggotaKeluargaController()),
        ChangeNotifierProvider(create: (_) => CatatanKeluargaController()),
      ],
      child: MaterialApp(
        title: 'MY PANDAK',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          fontFamily: 'Poppins',
        ),
        home: const SplashPage(),
        // Add global route observer for debugging
        navigatorObservers: [
          RouteObserver<PageRoute>(),
        ],
      ),
    );
  }
}
