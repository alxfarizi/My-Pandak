import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class UbahKataSandiPage extends StatefulWidget {
  const UbahKataSandiPage({super.key});

  @override
  State<UbahKataSandiPage> createState() => _UbahKataSandiPageState();
}

class _UbahKataSandiPageState extends State<UbahKataSandiPage> {
  static const String _font = 'Poppins';
  static const double _gapSmall = 14;
  static const double _gapMedium = 20;
  static const double _gapLarge = 28;

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  bool get _isFormValid {
    return _currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _newPasswordController.text == _confirmPasswordController.text &&
        _newPasswordController.text.length >= 6 &&
        _newPasswordController.text != _currentPasswordController.text;
  }

  Future<void> _updatePassword() async {
    if (!_isFormValid) {
      _showError('Pastikan semua field terisi dengan benar dan password baru minimal 6 karakter');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authController = context.read<AuthController>();

      // Note: In real implementation, you should verify current password first
      // For demo purposes, we'll proceed directly to change password

      await authController.changePassword(_newPasswordController.text);

      _showSuccess('Password berhasil diperbarui!');
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context, true);
    } catch (e) {
      _showError('Gagal memperbarui password: $e');
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

  InputDecoration _inputDecoration(String hint, {bool withEye = false, Widget? prefixIcon, VoidCallback? onToggleVisibility, bool isVisible = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontFamily: _font, fontSize: 12),
      border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A3669), width: 3)),
      isDense: true,
      suffixIcon: withEye ? IconButton(
        icon: Icon(
          isVisible ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: onToggleVisibility,
      ) : null,
      prefixIcon: prefixIcon,
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
          'Ubah Kata Sandi',
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
              'Kata Sandi anda saat ini',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _currentPasswordController,
              obscureText: !_showCurrentPassword,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                'Masukkan password saat ini',
                withEye: true,
                isVisible: _showCurrentPassword,
                onToggleVisibility: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
                prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
              ),
              style: const TextStyle(fontFamily: _font),
            ),
            const SizedBox(height: _gapMedium),
            const Text(
              'Kata Sandi baru',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _newPasswordController,
              obscureText: !_showNewPassword,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                'Masukkan password baru (min. 6 karakter)',
                withEye: true,
                isVisible: _showNewPassword,
                onToggleVisibility: () => setState(() => _showNewPassword = !_showNewPassword),
                prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
              ),
              style: const TextStyle(fontFamily: _font),
            ),
            const SizedBox(height: _gapMedium),
            const Text(
              'Konfirmasi Kata Sandi baru',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: _font,
              ),
            ),
            const SizedBox(height: _gapSmall),
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_showConfirmPassword,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                'Ulangi password baru anda',
                withEye: true,
                isVisible: _showConfirmPassword,
                onToggleVisibility: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
              ),
              style: const TextStyle(fontFamily: _font),
            ),
            // Validation feedback
            if (_newPasswordController.text.isNotEmpty || _confirmPasswordController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ValidationItem(
                    'Password minimal 6 karakter',
                    _newPasswordController.text.length >= 6,
                  ),
                  _ValidationItem(
                    'Konfirmasi password harus sama',
                    _newPasswordController.text == _confirmPasswordController.text && _confirmPasswordController.text.isNotEmpty,
                  ),
                  _ValidationItem(
                    'Password baru harus berbeda dari yang lama',
                    _newPasswordController.text != _currentPasswordController.text && _newPasswordController.text.isNotEmpty,
                  ),
                ],
              ),
            ],
            const SizedBox(height: _gapLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFormValid ? _updatePassword : null,
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

class _ValidationItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const _ValidationItem(this.text, this.isValid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isValid ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isValid ? Colors.green : Colors.red,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
