//splash_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'login_page.dart';
import 'dashboard_page.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialize auth controller
    final authController = context.read<AuthController>();
    await authController.initialize();

    // Wait minimum 2 seconds for splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // FIXED: Check both login status and remember me preference
    final shouldAutoLogin = await AuthService.shouldAutoLogin();

    if (authController.isLoggedIn && shouldAutoLogin) {
      // Auto login if user is logged in and remember me is enabled
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else {
      // If not remember me or not logged in, go to login
      if (authController.isLoggedIn && !shouldAutoLogin) {
        // User is logged in but remember me is off, so logout
        await authController.logout();
      }

      // Set timer for auto-navigate to login if user doesn't interact
      _navTimer = Timer(const Duration(seconds: 8), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      });
    }
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Allow user to skip splash by tapping
            _navTimer?.cancel();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              final topPad = (h / 852 * 173).clamp(80.0, 220.0) as double;
              final logoSize = (w * 0.9).clamp(240.0, 350.0) as double;
              final titleSize = (w / 393 * 40).clamp(28.0, 48.0) as double;
              final taglineSize = (w / 393 * 14).clamp(12.0, 18.0) as double;
              final creditSize = (w / 393 * 12).clamp(10.0, 16.0) as double;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: topPad),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/logo_aplikasi.png',
                                  width: logoSize,
                                  height: logoSize,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 24),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'My ',
                                        style: TextStyle(
                                          color: const Color(0xFF00C4FF),
                                          fontSize: titleSize,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Pandak',
                                        style: TextStyle(
                                          color: const Color(0xFF1A3669),
                                          fontSize: titleSize,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Digitalisasi Desa Mulai dari My Pandak',
                                  style: TextStyle(
                                    color: const Color(0xFF717171),
                                    fontSize: taglineSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                // Loading indicator
                                Consumer<AuthController>(
                                  builder: (context, authController, child) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Color(0xFF1A3669),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Memuat aplikasi...',
                                          style: TextStyle(
                                            color: const Color(0xFF717171),
                                            fontSize: taglineSize * 0.8,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Column(
                            children: [
                              Text(
                                'Dikembangkan oleh Tim Developer My Pandak',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF1A3669),
                                  fontSize: creditSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ketuk layar untuk melanjutkan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF717171),
                                  fontSize: creditSize * 0.9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
