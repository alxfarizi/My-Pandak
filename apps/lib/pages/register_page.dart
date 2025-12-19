import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                '.figma/image/mi612w4r-oz1z9fs.png',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 174,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A3669),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('NIK', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(hint: 'Masukan NIK atau Email Google Anda', prefix: const Icon(Icons.assignment_ind, color: Colors.grey)),
                    const SizedBox(height: 16),
                    const Text('Email google', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(hint: 'Masukan NIK atau Email Google Anda', prefix: const Icon(Icons.g_mobiledata, color: Colors.grey, size: 35)),
                    const SizedBox(height: 16),
                    const Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(hint: 'Password', obscure: true, prefix: const Icon(Icons.key, color: Colors.grey), suffix: const Icon(Icons.visibility, color: Colors.grey)),
                    const SizedBox(height: 16),
                    const Text('Ulangi Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(hint: 'Password', obscure: true, prefix: const Icon(Icons.key, color: Colors.grey), suffix: const Icon(Icons.visibility, color: Colors.grey)),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3669),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const DashboardPage()),
                          );
                        },
                        icon: const Icon(Icons.account_circle, color: Colors.white),
                        label: const Text(
                          'Daftarkan Akun',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;

  const _TextField({
    required this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: const InputDecoration().copyWith(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 13),
        prefixIcon: prefix,
        suffixIcon: suffix,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1A3669), width: 3),
        ),
      ),
    );
  }
}