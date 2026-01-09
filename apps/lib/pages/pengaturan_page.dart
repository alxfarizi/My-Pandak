//pengaturan_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_page.dart';
import 'cetak_data_page.dart';
import 'register_warga_page.dart';
import 'ubah_nik_page.dart';
import 'ubah_email_page.dart';
import 'ubah_kata_sandi_page.dart';
import 'login_page.dart';
import '../controllers/auth_controller.dart';
import '../widgets/route_guard.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _navigateToSettingsPage(BuildContext context, Widget page) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );

    // Refresh profile data if settings were updated
    if (result == true) {
      context.read<AuthController>().loadUserProfile();
    }
  }
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

    void navigateToCetakData(BuildContext ctx) {
      Navigator.of(ctx).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a, b) => const CetakDataPage(),
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
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Consumer<AuthController>(
            builder: (context, authController, child) {
              final profile = authController.userProfile;
              final namaLengkap = profile?['nama_lengkap'] ?? 'User';
              final nik = profile?['nik'] ?? 'Belum ada NIK';

              return Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3669),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 73,
                      height: 73,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaLengkap,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'NIK: $nik',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildSettingsItem(
                  icon: Icons.badge,
                  title: 'Ubah NIK(Nomor Induk Kependudukan)',
                  onTap: () {
                    _navigateToSettingsPage(context, const UbahNikPage());
                  },
                ),
                const SizedBox(height: 8),
                _buildSettingsItem(
                  icon: Icons.mail,
                  title: 'Ubah Email Google',
                  onTap: () {
                    _navigateToSettingsPage(context, const UbahEmailGooglePage());
                  },
                ),
                const SizedBox(height: 8),
                _buildSettingsItem(
                  icon: Icons.lock,
                  title: 'Ubah Kata Sandi',
                  onTap: () {
                    _navigateToSettingsPage(context, const UbahKataSandiPage());
                  },
                ),
                const SizedBox(height: 8),
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: 'Keluar Akun',
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // FIXED: Dynamic bottom navigation based on role
      bottomNavigationBar: Consumer<AuthController>(
        builder: (context, authController, child) {
          if (authController.isWarga) {
            // Warga navbar (3 items)
            return _buildWargaBottomNav(context);
          } else {
            // Admin/Pengurus navbar (4 items)
            return _buildPengurusBottomNav(context, authController.isPengurus);
          }
        },
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black54, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black, size: 24),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  // FIXED: Warga navbar (3 items)
  Widget _buildWargaBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 2, // Settings is index 2 for warga
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
          if (index == 2) return; // Already on settings
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, a, b) => const DashboardPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (c, a, b, child) => child,
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, a, b) => const CetakDataPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (c, a, b, child) => child,
              ),
            );
          }
        },
      ),
    );
  }

  // FIXED: Admin/Pengurus navbar (4 items)
  Widget _buildPengurusBottomNav(BuildContext context, bool isPengurus) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 3, // Settings is index 3 for pengurus
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
          if (index == 3) return; // Already on settings
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, a, b) => const DashboardPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (c, a, b, child) => child,
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, a, b) => const CetakDataPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (c, a, b, child) => child,
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
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
        },
      ),
    );
  }

  // Logout dialog tetap sama seperti sebelumnya
  void _showLogoutDialog(BuildContext context) {
    final authController = context.read<AuthController>();
    final profile = authController.userProfile;
    final nik = profile?['nik'] ?? 'User';

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 8),
                    child: Column(
                      children: [
                        Text(
                          'Keluar dari $nik',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Yakin keluar dari akun ini ? Jika anda sudah keluar dan ingin mengisi data kembali, maka anda harus masuk kembali ke akun ini ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<AuthController>(
                    builder: (context, authController, child) {
                      if (authController.isLoading) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1A3669),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Sedang keluar...',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF616161),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFFA0A0A0)),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                try {
                                  await authController.logout();

                                  if (dialogContext.mounted) {
                                    Navigator.of(dialogContext).pop();
                                  }

                                  await Future.delayed(const Duration(milliseconds: 100));

                                  if (context.mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => const LoginPage(),
                                      ),
                                          (route) => false,
                                    );
                                  }
                                } catch (e) {
                                  if (dialogContext.mounted) {
                                    Navigator.of(dialogContext).pop();
                                  }

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Gagal logout: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFFA0A0A0)),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF44336),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
