//register_warga_page.dart - FIXED PROPER NAVIGATION
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import 'dashboard_page.dart';
import 'cetak_data_page.dart';
import 'pengaturan_page.dart';

class RegisterWargaPage extends StatefulWidget {
  // FIXED: Add parameter to track where we came from
  final String? previousRoute;

  const RegisterWargaPage({super.key, this.previousRoute});

  @override
  State<RegisterWargaPage> createState() => _RegisterWargaPageState();
}

class _RegisterWargaPageState extends State<RegisterWargaPage> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nikController.dispose();
    _namaLengkapController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateForm() {
    if (_nikController.text.trim().isEmpty) {
      return 'NIK wajib diisi';
    }
    if (_namaLengkapController.text.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (_emailController.text.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    if (_passwordController.text.trim().isEmpty) {
      return 'Password wajib diisi';
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }

    final nik = _nikController.text.trim();
    if (nik.length != 16) {
      return 'NIK harus 16 digit';
    }
    if (!RegExp(r'^\d+$').hasMatch(nik)) {
      return 'NIK hanya boleh berisi angka';
    }

    final email = _emailController.text.trim();
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Format email tidak valid';
    }

    if (_passwordController.text.length < 6) {
      return 'Password minimal 6 karakter';
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Password tidak cocok';
    }

    final nama = _namaLengkapController.text.trim();
    if (nama.length < 2) {
      return 'Nama lengkap minimal 2 karakter';
    }

    return null;
  }

  Future<void> _handleRegister() async {
    final validationError = _validateForm();
    if (validationError != null) {
      _showError(validationError);
      return;
    }

    final authController = context.read<AuthController>();

    final success = await authController.registerWargaByAdmin(
      nik: _nikController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
      namaLengkap: _namaLengkapController.text.trim(),
    );

    if (success && mounted) {
      _showSuccess('Registrasi warga berhasil!');
      _navigateBack();
    } else if (authController.error != null && mounted) {
      _showError(authController.error!);
    }
  }

  // FIXED: Smart navigation based on previous route
  void _navigateBack() {
    if (!mounted) return;

    final navigator = Navigator.of(context);

    // FIXED: Navigate based on where we came from
    if (widget.previousRoute != null) {
      switch (widget.previousRoute) {
        case 'cetak_data':
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const CetakDataPage()),
          );
          break;
        case 'pengaturan':
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
          break;
        case 'dashboard':
        default:
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
          break;
      }
    } else {
      // Fallback: try to pop, if can't then go to dashboard
      if (navigator.canPop()) {
        navigator.pop();
      } else {
        navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _navigateBack,
          ),
          title: const Text(
            'Registrasi Warga',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daftar Akun Warga',
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
                _TextField(
                  controller: _nikController,
                  hint: 'Masukan NIK Warga (16 digit)',
                  prefix: const Icon(Icons.assignment_ind, color: Colors.grey),
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                ),
                const SizedBox(height: 16),
                const Text('Nama Lengkap', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                _TextField(
                  controller: _namaLengkapController,
                  hint: 'Masukan Nama Lengkap Warga',
                  prefix: const Icon(Icons.person, color: Colors.grey),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                const Text('Email google', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                _TextField(
                  controller: _emailController,
                  hint: 'Masukan Email Google Warga',
                  prefix: const Icon(Icons.g_mobiledata, color: Colors.grey, size: 35),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                const Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                _TextField(
                  controller: _passwordController,
                  hint: 'Password (minimal 6 karakter)',
                  obscure: _obscurePassword,
                  prefix: const Icon(Icons.key, color: Colors.grey),
                  suffix: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Ulangi Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                _TextField(
                  controller: _confirmPasswordController,
                  hint: 'Ulangi Password',
                  obscure: _obscureConfirmPassword,
                  prefix: const Icon(Icons.key, color: Colors.grey),
                  suffix: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<AuthController>(
                  builder: (context, authController, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3669),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: authController.isLoading ? null : _handleRegister,
                        icon: authController.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Icon(Icons.person_add, color: Colors.white),
                        label: Text(
                          authController.isLoading ? 'Mendaftar...' : 'Daftarkan Warga',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;

  const _TextField({
    required this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.controller,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: const InputDecoration().copyWith(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 13),
        prefixIcon: prefix,
        suffixIcon: suffix,
        counterText: maxLength != null ? '' : null,
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
