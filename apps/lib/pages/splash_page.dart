import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';

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
    _navTimer = Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
    });
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          'Dikembangkan oleh Tim Developer My Pandak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF1A3669),
                            fontSize: creditSize,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
