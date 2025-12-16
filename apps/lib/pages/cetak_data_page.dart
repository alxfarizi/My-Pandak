import 'package:flutter/material.dart';
import 'pengaturan_page.dart';
import 'dashboard_page.dart';
import 'cetak_data_data_warga_page.dart';
import 'cetak_data_data_keluarga_page.dart';
import 'cetak_data_catatan_keluarga_page.dart';

import 'register_page.dart';

class CetakDataPage extends StatelessWidget {
  const CetakDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToDashboard(BuildContext ctx) {
      Navigator.of(ctx).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a, b) => const DashboardPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (c, a, b, child) => child,
        ),
      );
    }

    void navigateToSettings(BuildContext ctx) {
      Navigator.of(ctx).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a, b) => const SettingsPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (c, a, b, child) => child,
        ),
      );
    }

    void navigateToRegister(BuildContext ctx) {
      Navigator.of(ctx).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a, b) => const RegisterPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (c, a, b, child) => child,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const Text(
          'Cetak Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pilih data yang akan dicetak',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _MenuCard(
                            icon: Icons.people,
                            label: 'Data\nWarga',
                            color: const Color(0xFF3D5A99),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CetakDataWargaPage()));
                            },
                          ),
                          _MenuCard(
                            icon: Icons.home_filled,
                            label: 'Data\nKeluarga',
                            color: const Color(0xFF4CAF50),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CetakDataKeluargaPage()));
                            },
                          ),
                          _MenuCard(
                            icon: Icons.note,
                            label: 'Catatan\nKeluarga',
                            color: const Color(0xFFFFA726),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CetakCatatanKeluargaPage()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0) {
            navigateToDashboard(context);
          } else if (index == 2) {
            navigateToRegister(context);
          } else if (index == 3) {
            navigateToSettings(context);
          }
        },
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const _BottomNav({
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2C4A7C),
        unselectedItemColor: Colors.grey,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: 'Cetak Data'),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: 'Registrasi'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}