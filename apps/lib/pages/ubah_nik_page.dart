//ubah_nik_page.dart - FIXED NIK VALIDATION
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class UbahNikPage extends StatefulWidget {
  const UbahNikPage({super.key});

  @override
  State<UbahNikPage> createState() => _UbahNikPageState();
}

class _UbahNikPageState extends State<UbahNikPage> {
  final TextEditingController _nikController = TextEditingController();
  String _currentNik = '';

  @override
  void initState() {
    super.initState();
    _loadCurrentNik();
  }

  void _loadCurrentNik() {
    final authController = context.read<AuthController>();
    final profile = authController.userProfile;
    if (profile != null) {
      _currentNik = profile['nik'] ?? '';
      _nikController.text = _currentNik;
    }
  }

  @override
  void dispose() {
    _nikController.dispose();
    super.dispose();
  }

  // FIXED: Enhanced NIK validation
  String? _validateNik(String nik) {
    if (nik.trim().isEmpty) {
      return 'NIK wajib diisi';
    }

    if (nik.length != 16) {
      return 'NIK harus 16 digit';
    }

    if (!RegExp(r'^\d+$').hasMatch(nik)) {
      return 'NIK hanya boleh berisi angka';
    }

    return null;
  }

  Future<void> _handleUpdateNik() async {
    final newNik = _nikController.text.trim();

    // FIXED: Comprehensive validation
    final validationError = _validateNik(newNik);
    if (validationError != null) {
      _showError(validationError);
      return;
    }

    // Check if NIK actually changed
    if (newNik == _currentNik) {
      _showError('NIK baru sama dengan NIK lama');
      return;
    }

    final authController = context.read<AuthController>();

    final success = await authController.updateProfile({
      'nik': newNik,
    });

    if (success && mounted) {
      _showSuccess('NIK berhasil diperbarui!');
      Navigator.pop(context, true); // Return true to indicate success
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

  // HANYA BAGIAN build method yang perlu ditambahkan info

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
          'Ubah NIK',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NIK Saat Ini',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                _currentNik.isEmpty ? 'Belum ada NIK' : _currentNik,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'NIK Baru',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nikController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              decoration: InputDecoration(
                hintText: 'Masukan NIK baru (16 digit)',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.assignment_ind, color: Colors.grey),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1A3669), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Consumer<AuthController>(
              builder: (context, authController, child) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A3669),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: authController.isLoading ? null : _handleUpdateNik,
                    child: authController.isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Informasi Penting',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• NIK harus 16 digit angka\n'
                        '• NIK tidak boleh sama dengan warga lain\n'
                        '• Perubahan NIK akan otomatis tersinkronisasi dengan data warga Anda\n'
                        '• Semua data keluarga yang terkait akan terupdate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
