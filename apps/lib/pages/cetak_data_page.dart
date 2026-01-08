//cetak_data_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pengaturan_page.dart';
import 'dashboard_page.dart';
import 'cetak_data_data_warga_page.dart';
import 'cetak_data_data_keluarga_page.dart';
import 'cetak_data_catatan_keluarga_page.dart';
import 'register_warga_page.dart';
import '../controllers/auth_controller.dart';
import '../widgets/route_guard.dart';

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
          pageBuilder: (context, a, b) => RouteGuard(
            allowedRoles: const ['Admin', 'Pengurus'],
            child: const RegisterWargaPage(),
          ),
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
      // FIXED: Dynamic bottom navigation based on role
      bottomNavigationBar: Consumer<AuthController>(
        builder: (context, authController, child) {
          if (authController.isWarga) {
            return _buildWargaBottomNav(context);
          } else {
            return _buildPengurusBottomNav(context);
          }
        },
      ),
    );
  }

  // FIXED: Warga navbar (3 items)
  Widget _buildWargaBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        currentIndex: 1, // Cetak Data is index 1 for warga
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2C4A7C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: 'Cetak Data'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
        onTap: (index) {
          if (index == 1) return; // Already on Cetak Data
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => const DashboardPage(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => const SettingsPage(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero),
            );
          }
        },
      ),
    );
  }

  // FIXED: Admin/Pengurus navbar (4 items)
  Widget _buildPengurusBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        currentIndex: 1, // Cetak Data is index 1
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2C4A7C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: 'Cetak Data'),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: 'Registrasi'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
        onTap: (index) {
          if (index == 1) return; // Already on Cetak Data
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => const DashboardPage(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => RouteGuard(
                  allowedRoles: const ['Admin', 'Pengurus'],
                  child: const RegisterWargaPage(),
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => const SettingsPage(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero),
            );
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
