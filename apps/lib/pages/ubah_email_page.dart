import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class UbahEmailGooglePage extends StatefulWidget {
  const UbahEmailGooglePage({super.key});

  @override
  State<UbahEmailGooglePage> createState() => _UbahEmailGooglePageState();
}

class _UbahEmailGooglePageState extends State<UbahEmailGooglePage> {
  static const String _font = 'Poppins';
  static const double _gapSmall = 14;
  static const double _gapMedium = 20;
  static const double _gapLarge = 28;

  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  bool _otpSent = false;
  String? _currentEmail;

  @override
  void initState() {
    super.initState();
    _loadCurrentEmail();
  }

  void _loadCurrentEmail() {
    final authController = context.read<AuthController>();
    final profile = authController.userProfile;
    _currentEmail = profile?['email'] ?? '';
    _currentEmailController.text = _currentEmail ?? '';
  }

  bool get _isNewEmailValid {
    final email = _newEmailController.text.trim();
    return email.isNotEmpty &&
        email.contains('@') &&
        email.contains('.') &&
        email != _currentEmail;
  }

  bool get _isFormValid {
    return _isNewEmailValid &&
        _otpController.text.trim().length == 6 &&
        _otpSent;
  }

  Future<void> _sendOtp() async {
    if (!_isNewEmailValid) {
      _showError('Masukkan email yang valid dan berbeda dari email saat ini');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate OTP sending (in real app, you'd integrate with email service)
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _otpSent = true);
      _showSuccess('Kode OTP telah dikirim ke ${_newEmailController.text}');
    } catch (e) {
      _showError('Gagal mengirim OTP: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _updateEmail() async {
    if (!_isFormValid) {
      _showError('Pastikan semua field terisi dengan benar');
      return;
    }

    // Simulate OTP verification
    if (_otpController.text != '123456') {
      _showError('Kode OTP tidak valid. Gunakan 123456 untuk demo.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authController = context.read<AuthController>();

      final success = await authController.updateProfile({
        'email': _newEmailController.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (success) {
        _showSuccess('Email berhasil diperbarui!');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context, true);
      } else {
        _showError(authController.error ?? 'Gagal memperbarui email');
      }
    } catch (e) {
      _showError('Terjadi kesalahan: $e');
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? prefixIcon, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontFamily: _font, fontSize: 12),
      border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A3669), width: 3)),
      isDense: true,
      prefixIcon: prefixIcon,
      suffix: suffix,
    );
  }

  @override
  void dispose() {
    _currentEmailController.dispose();
    _newEmailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ubah Email Google',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: _font,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: _gapLarge),
            const Text(
              'Email google anda saat ini',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _currentEmailController,
              enabled: false,
              decoration: _inputDecoration(
                'Email saat ini',
                prefixIcon: const Icon(Icons.mail, size: 18, color: Colors.grey),
              ),
              style: const TextStyle(
                fontFamily: _font,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: _gapMedium),
            const Text(
              'Email google baru anda',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _newEmailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                'Masukkan email baru anda',
                prefixIcon: const Icon(Icons.mail, size: 18, color: Colors.grey),
                suffix: TextButton(
                  onPressed: _isNewEmailValid && !_otpSent ? _sendOtp : null,
                  child: Text(
                    _otpSent ? 'OTP Terkirim' : 'Kirim OTP',
                    style: TextStyle(
                      color: _otpSent ? Colors.green : (_isNewEmailValid ? const Color(0xFF1A3669) : const Color(0xFFA0A0A0)),
                      fontSize: 12,
                      fontFamily: _font,
                    ),
                  ),
                ),
              ),
              style: const TextStyle(fontFamily: _font),
            ),
            const SizedBox(height: _gapMedium),
            const Text(
              'Kode OTP',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              enabled: _otpSent,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                _otpSent ? 'Masukkan kode 6 digit' : 'Kirim OTP terlebih dahulu',
                prefixIcon: const Icon(Icons.lock_outline, size: 18, color: Colors.grey),
              ),
              style: const TextStyle(fontFamily: _font),
            ),
            if (_otpSent) ...[
              const SizedBox(height: 8),
              Text(
                'Demo: Gunakan kode "123456" untuk verifikasi',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: _gapLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFormValid ? _updateEmail : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid ? const Color(0xFF1A3669) : const Color(0xFFA0A0A0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: _font,
                  ),
                ),
                child: const Text('Konfirmasi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
