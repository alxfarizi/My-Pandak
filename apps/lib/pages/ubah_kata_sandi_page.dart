import 'package:flutter/material.dart';

class UbahKataSandiPage extends StatelessWidget {
  const UbahKataSandiPage({super.key});

  static const String _font = 'Poppins';
  static const double _gapSmall = 14;
  static const double _gapMedium = 20;
  static const double _gapLarge = 28;

  InputDecoration _inputDecoration(String hint, {bool withEye = false, Widget? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFA0A0A0), fontFamily: _font, fontSize: 12),
      border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA0A0A0), width: 3)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A3669), width: 3)),
      isDense: true,
      suffixIcon: withEye ? const Icon(Icons.visibility, color: Colors.grey) : null,
      prefixIcon: prefixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Ubah Kata Sandi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: _font)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: _gapLarge),
          const Text('Kata Sandi anda saat ini', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: _font)),
          SizedBox(height: _gapSmall),
          TextField(
            decoration: _inputDecoration(
              '1234567',
              withEye: true,
              prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
            ),
            style: const TextStyle(fontFamily: _font),
          ),
          SizedBox(height: _gapMedium),
          const Text('Kata Sandi baru', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: _font)),
          SizedBox(height: _gapSmall),
          TextField(
            decoration: _inputDecoration(
              'Masukan Kata Sandi baru anda',
              withEye: true,
              prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
            ),
            style: const TextStyle(fontFamily: _font),
          ),
          SizedBox(height: _gapMedium),
          const Text('Konfirmasi Kata Sandi baru', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: _font)),
          SizedBox(height: _gapSmall),
          TextField(
            decoration: _inputDecoration(
              'Ulangi Kata Sandi baru anda',
              withEye: true,
              prefixIcon: const Icon(Icons.key, size: 22, color: Colors.grey),
            ),
            style: const TextStyle(fontFamily: _font),
          ),
          SizedBox(height: _gapLarge),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA0A0A0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: _font),
              ),
              child: const Text('Konfirmasi'),
            ),
          ),
        ]),
      ),
    );
  }
}