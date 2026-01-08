//register_page.dart - ADDED BACK MENU
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_page.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // FIXED: Enhanced validation with comprehensive checks
  String? _validateForm() {
    // Check for empty fields
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

    // Validate NIK format
    final nik = _nikController.text.trim();
    if (nik.length != 16) {
      return 'NIK harus 16 digit';
    }
    if (!RegExp(r'^\d+$').hasMatch(nik)) {
      return 'NIK hanya boleh berisi angka';
    }

    // Validate email format
    final email = _emailController.text.trim();
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Format email tidak valid';
    }

    // Validate password
    if (_passwordController.text.length < 6) {
      return 'Password minimal 6 karakter';
    }

    // Check password match
    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Password tidak cocok';
    }

    // Validate nama lengkap (minimal 2 karakter, bukan 2 kata)
    final nama = _namaLengkapController.text.trim();
    if (nama.length < 2) {
      return 'Nama lengkap minimal 2 karakter';
    }

    return null; // All validations passed
  }

  Future<void> _handleRegister() async {
    // FIXED: Comprehensive form validation
    final validationError = _validateForm();
    if (validationError != null) {
      _showError(validationError);
      return;
    }

    final authController = context.read<AuthController>();

    final success = await authController.register(
      nik: _nikController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
      namaLengkap: _namaLengkapController.text.trim(),
      role: 'Pengurus', // Default role untuk register dari login screen
    );

    if (success && mounted) {
      _showSuccess('Registrasi berhasil! Silakan login.');
      Navigator.of(context).pop(); // Kembali ke login page
    } else if (authController.error != null && mounted) {
      _showError(authController.error!);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // FIXED: Add AppBar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
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
                    _TextField(
                      controller: _nikController,
                      hint: 'Masukan NIK Anda (16 digit)',
                      prefix: const Icon(Icons.assignment_ind, color: Colors.grey),
                      keyboardType: TextInputType.number,
                      maxLength: 16, // FIXED: Limit NIK input to 16 digits
                    ),
                    const SizedBox(height: 16),
                    const Text('Nama Lengkap', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(
                      controller: _namaLengkapController,
                      hint: 'Masukan Nama Lengkap Anda',
                      prefix: const Icon(Icons.person, color: Colors.grey),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    const Text('Email google', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _TextField(
                      controller: _emailController,
                      hint: 'Masukan Email Google Anda',
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
                                : const Icon(Icons.account_circle, color: Colors.white),
                            label: Text(
                              authController.isLoading ? 'Mendaftar...' : 'Daftarkan Akun',
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
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength; // FIXED: Added maxLength parameter

  const _TextField({
    required this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.controller,
    this.keyboardType,
    this.maxLength, // FIXED: Added maxLength parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength, // FIXED: Apply maxLength
      decoration: const InputDecoration().copyWith(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 13),
        prefixIcon: prefix,
        suffixIcon: suffix,
        counterText: maxLength != null ? '' : null, // FIXED: Hide counter for NIK
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
