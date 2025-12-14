import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'cetak_data_page.dart';
import 'register_page.dart';
import 'ubah_nik_page.dart';
import 'ubah_email_page.dart';
import 'ubah_kata_sandi_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          Container(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agus',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NIK: 33211098765984',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildSettingsItem(icon: Icons.badge, title: 'Ubah NIK(Nomor Induk Kependudukan)', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UbahNikPage()));
                }),
                const SizedBox(height: 8),
                _buildSettingsItem(icon: Icons.mail, title: 'Ubah Email Google', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UbahEmailGooglePage()));
                }),
                const SizedBox(height: 8),
                _buildSettingsItem(icon: Icons.lock, title: 'Ubah Kata Sandi', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UbahKataSandiPage()));
                }),
                const SizedBox(height: 8),
                _buildSettingsItem(icon: Icons.logout, title: 'Keluar Akun', onTap: () { _showLogoutDialog(context);}),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(
        context,
        3,
            (index) {
          if (index == 3) return;
          if (index == 0) {
            navigateToDashboard(context);
          } else if (index == 1) {
            navigateToCetakData(context);
          } else if (index == 2) {
            navigateToRegister(context);
          }
        },
      ),
    );
  }

  Widget _buildSettingsItem({required IconData icon, required String title, required VoidCallback onTap,}) {
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
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
        trailing: const Icon(Icons.chevron_right, color: Colors.black, size: 24),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex, Function(int)? onTap) {
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
        currentIndex: currentIndex,
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
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 8),
                child: Column(
                  children: const [
                    Text('Keluar dari 33211098765984', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    Text('Yakin keluar dari akun ini ? Jika anda sudah keluar dan ingin mengisi data kembali, maka anda harus masuk kembali ke akun ini ?', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  ],
                ),
              ),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(color: const Color(0xFFA0A0A0))), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8))),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      alignment: Alignment.center,
                      child: const Text('Batal', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(color: const Color(0xFFA0A0A0))), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8))),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      alignment: Alignment.center,
                      child: const Text('Keluar', style: TextStyle(fontSize: 14, color: Color(0xFFF44336))),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}