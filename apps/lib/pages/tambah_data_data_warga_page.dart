import 'package:flutter/material.dart';

class TambahDataWargaPage extends StatefulWidget {
  const TambahDataWargaPage({super.key});

  @override
  State<TambahDataWargaPage> createState() => _TambahDataWargaPageState();
}

class _DashedPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  _DashedPainter({required this.color, required this.dashWidth, required this.dashGap, required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double x = 0;
    while (x < size.width) {
      double endX = x + dashWidth;
      if (endX > size.width) {
        endX = size.width;
      }
      canvas.drawLine(Offset(x, 0), Offset(endX, 0), paint);
      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TambahDataWargaPageState extends State<TambahDataWargaPage> {
  final TextEditingController _desaWismaController = TextEditingController();
  final TextEditingController _namaKepalaController = TextEditingController();
  final TextEditingController _noRegistrasiController = TextEditingController();
  final TextEditingController _noKtpNikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _bulanLahirController = TextEditingController();
  final TextEditingController _tahunLahirController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _desaKelController = TextEditingController();
  final TextEditingController _kabKotaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jenisAkseptorKbController = TextEditingController();
  final TextEditingController _frekuensiPosyanduController = TextEditingController();

  String? _jenisKelamin;
  String? _statusPerkawinan;
  String? _statusDalamKeluarga;
  String? _agama;
  String? _statusTinggal;
  String? _pendidikan;
  String? _pekerjaan;
  String? _akseptorKb;
  String? _aktifPosyandu;
  String? _binaBalita;
  String? _memilikiTabungan;
  String? _ikutPaud;
  String? _ikutKoperasi;
  String? _berkebutuhanKhusus;
  String? _paketTabungan;

  static const double _labelFontSize = 12;
  static const double _valueFontSize = 12;
  static const EdgeInsets _sectionPadding = EdgeInsets.zero;
  static const double _labelWidth = 135;
  static const double _colonWidth = 12;
  static const double _labelTopOffset = 0;
  static const double _rightGap = 10;
  static const double _gapSmall = 8;
  static const double _gapMedium = 10;
  final Color _dotColor = const Color(0xFFA0A0A0);
  static const String _fontFamily = 'Poppins';

  @override
  void dispose() {
    _desaWismaController.dispose();
    _namaKepalaController.dispose();
    _noRegistrasiController.dispose();
    _noKtpNikController.dispose();
    _namaController.dispose();
    _jabatanController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _bulanLahirController.dispose();
    _tahunLahirController.dispose();
    _umurController.dispose();
    _desaKelController.dispose();
    _kabKotaController.dispose();
    _alamatController.dispose();
    _jenisAkseptorKbController.dispose();
    _frekuensiPosyanduController.dispose();
    super.dispose();
  }

  Widget _buildTwoColRow({required String label, required Widget right, double labelTopOffset = _labelTopOffset, CrossAxisAlignment rowAlign = CrossAxisAlignment.center, bool showColon = true,}) {
    return Row(crossAxisAlignment: rowAlign, children: [
      SizedBox(width: _labelWidth, child: Padding(padding: EdgeInsets.only(top: labelTopOffset), child: Text(label, style: const TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: _fontFamily)))),
      SizedBox(width: _colonWidth, child: Padding(padding: EdgeInsets.only(top: labelTopOffset), child: showColon ? const Text(':', textAlign: TextAlign.center, style: TextStyle(fontSize: _labelFontSize, color: Colors.black, fontFamily: _fontFamily)) : const SizedBox.shrink())),
      const SizedBox(width: _rightGap),
      Expanded(child: right),
    ]);
  }

  Widget _dottedUnderline() {
    return LayoutBuilder(builder: (context, constraints) { return SizedBox(height: 1, child: CustomPaint(size: Size(constraints.maxWidth, 1), painter: _DashedPainter(color: _dotColor, dashWidth: 3, dashGap: 4, thickness: 1))); });
  }

  Widget _buildDottedInput(String label, TextEditingController controller, {String? placeholder}) {
    return _buildTwoColRow(label: label, labelTopOffset: _labelTopOffset, right: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(controller: controller, decoration: InputDecoration(hintText: placeholder ?? '', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
      _dottedUnderline(),
    ]));
  }

  Widget _buildCheckboxGroup(String label, List<String> options, String? value, Function(String?) onChanged, {CrossAxisAlignment rowAlign = CrossAxisAlignment.center, bool showColon = true}) {
    return _buildTwoColRow(label: label, labelTopOffset: _labelTopOffset, rowAlign: rowAlign, showColon: showColon, right: Wrap(spacing: 12, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: options.map((option) {
      return InkWell(onTap: () => onChanged(value == option ? null : option), borderRadius: BorderRadius.circular(4), child: Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2), child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(2), color: Colors.white), child: value == option ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2)))) : null),
        const SizedBox(width: 6),
        Text(option, style: const TextStyle(fontSize: _valueFontSize, color: Colors.black, fontFamily: _fontFamily)),
        const SizedBox(width: 12),
      ])));
    }).toList()));
  }

  Widget _buildDateInput() {
    return _buildTwoColRow(label: '7. Tgl Lahir / Umur', labelTopOffset: _labelTopOffset, right: Row(children: [
      Expanded(flex: 2, child: Column(children: [TextField(controller: _tanggalLahirController, decoration: InputDecoration(hintText: 'Tgl', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily), textAlign: TextAlign.center), _dottedUnderline()])),
      const Text('/', style: TextStyle(fontSize: _valueFontSize)),
      Expanded(flex: 2, child: Column(children: [TextField(controller: _bulanLahirController, decoration: InputDecoration(hintText: 'Bln', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily), textAlign: TextAlign.center), _dottedUnderline()])),
      const Text('/', style: TextStyle(fontSize: _valueFontSize)),
      Expanded(flex: 2, child: Column(children: [TextField(controller: _tahunLahirController, decoration: InputDecoration(hintText: 'Thn', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily), textAlign: TextAlign.center), _dottedUnderline()])),
      const SizedBox(width: 12),
      const Text('Umur', style: TextStyle(fontSize: _valueFontSize, color: Colors.black, fontFamily: _fontFamily)),
      const SizedBox(width: 6),
      Expanded(flex: 2, child: Column(children: [TextField(controller: _umurController, decoration: InputDecoration(hintText: '....', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily), textAlign: TextAlign.center), _dottedUnderline()])),
      const SizedBox(width: 6),
      const Text('Tahun', style: TextStyle(fontSize: _valueFontSize, color: Colors.black, fontFamily: _fontFamily)),
    ]));
  }

  Widget _buildFrequencyInput() {
    return _buildTwoColRow(label: 'Frekuensi / volume', labelTopOffset: _labelTopOffset, right: Row(children: [
      Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [TextField(controller: _frekuensiPosyanduController, decoration: InputDecoration(hintText: '1', hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)), style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily), textAlign: TextAlign.center), _dottedUnderline()])),
      const SizedBox(width: 6),
      const Text('Kali', style: TextStyle(fontSize: _valueFontSize, color: Colors.black, fontFamily: _fontFamily)),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 61,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: const Text('Data Warga', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildDottedInput('Desa Wisma', _desaWismaController, placeholder: 'Masukan Mawar'),
          const SizedBox(height: _gapSmall),
          _buildDottedInput('Nama Kepala', _namaKepalaController, placeholder: 'Masukan Kepala Keluarga'),
          const SizedBox(height: _gapMedium),
          const Text('Rumah Tangga', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w500)),
          const SizedBox(height: _gapSmall),
          Padding(padding: _sectionPadding, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildDottedInput('1. No. Registrasi', _noRegistrasiController, placeholder: 'Nomor Kepala Keluarga'),
            const SizedBox(height: _gapSmall),
            _buildDottedInput('2. No. KTP/NIK', _noKtpNikController, placeholder: 'Nomor KTP / NIK'),
            const SizedBox(height: _gapSmall),
            _buildDottedInput('3. Nama', _namaController, placeholder: 'Nama anggota keluarga'),
            const SizedBox(height: _gapSmall),
            _buildDottedInput('4. Jabatan', _jabatanController, placeholder: 'Jabatan dalam keluarga'),
          ])),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('5. Jenis Kelamin', ['Laki-laki', 'Perempuan'], _jenisKelamin, (value) => setState(() => _jenisKelamin = value)),
          const SizedBox(height: _gapMedium),
          _buildDottedInput('6. Tempat Lahir', _tempatLahirController, placeholder: 'Cth Purwokerto'),
          const SizedBox(height: _gapMedium),
          _buildDateInput(),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('8. Status Perkawinan', ['Menikah', 'Lajang', 'Janda', 'Duda'], _statusPerkawinan, (value) => setState(() => _statusPerkawinan = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: 16),
          _buildCheckboxGroup('9. Status Dalam Keluarga', ['Kepala Keluarga', 'Anggota Keluarga'], _statusDalamKeluarga, (value) => setState(() => _statusDalamKeluarga = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: 16),
          _buildCheckboxGroup('10. Agama', ['Islam', 'Kristen', 'Konhucu', 'Hindu', 'Katolik', 'Budha'], _agama, (value) => setState(() => _agama = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: 16),
          const Text('11. Alamat', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w500)),
          const SizedBox(height: _gapSmall),
          Padding(padding: _sectionPadding, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildDottedInput('Alamat', _alamatController, placeholder: 'Alamat anda'),
            const SizedBox(height: _gapSmall),
            _buildCheckboxGroup('Status Tinggal', ['Mukim', 'Perantauan'], _statusTinggal, (value) => setState(() => _statusTinggal = value)),
            const SizedBox(height: _gapSmall),
            _buildDottedInput('Desa / Kel / Sejenis', _desaKelController, placeholder: 'Cth. Pandak'),
            const SizedBox(height: _gapSmall),
            _buildDottedInput('Kab / Kota', _kabKotaController, placeholder: 'Cth. Banyumas'),
          ])),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('12. Pendidikan', ['Tidak tamat sd', 'SD / MI', 'SMP / Sederajat', 'SMU / SMK / Sederajat', 'Diploma', 'S1', 'S2', 'S3'], _pendidikan, (value) => setState(() => _pendidikan = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('13. Pekerjaan', ['Petani', 'Pedagang', 'Wirausaha', 'Swasta', 'TNI / Polri', 'Lainnya'], _pekerjaan, (value) => setState(() => _pekerjaan = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('14. Akseptor KB', ['Ya', 'Tidak'], _akseptorKb, (value) => setState(() => _akseptorKb = value)),
          const SizedBox(height: _gapSmall),
          if (_akseptorKb == 'Ya') Padding(padding: _sectionPadding, child: _buildDottedInput('Jenis Akseptor KB', _jenisAkseptorKbController, placeholder: 'Kondom Sutra Merah')),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('15. Aktif dalam Posyandu', ['Ya', 'Tidak'], _aktifPosyandu, (value) => setState(() => _aktifPosyandu = value)),
          const SizedBox(height: _gapSmall),
          if (_aktifPosyandu == 'Ya') Padding(padding: _sectionPadding, child: _buildFrequencyInput()),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('16. Mengikuti program bina keluarga balita', ['Ya', 'Tidak'], _binaBalita, (value) => setState(() => _binaBalita = value)),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('17. Memiliki Tabungan', ['Ya', 'Tidak'], _memilikiTabungan, (value) => setState(() => _memilikiTabungan = value), rowAlign: CrossAxisAlignment.start),
          const SizedBox(height: _gapSmall),
          if (_memilikiTabungan == 'Ya') Padding(padding: _sectionPadding, child: _buildCheckboxGroup('', ['Paket A', 'Paket B', 'Paket C', 'KF'], _paketTabungan, (value) => setState(() => _paketTabungan = value), rowAlign: CrossAxisAlignment.start, showColon: false)),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('18. Mengikuti PAUD', ['Ya', 'Tidak'], _ikutPaud, (value) => setState(() => _ikutPaud = value)),
          const SizedBox(height: _gapMedium),
          _buildCheckboxGroup('19. Ikut dalam kegiatan koperasi', ['Ya', 'Tidak'], _ikutKoperasi, (value) => setState(() => _ikutKoperasi = value)),
          const SizedBox(height: 16),
          _buildCheckboxGroup('20. Berkebutuhan Khusus', ['Ya', 'Tidak'], _berkebutuhanKhusus, (value) => setState(() => _berkebutuhanKhusus = value)),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            OutlinedButton.icon(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFD32F2F), width: 2), foregroundColor: const Color(0xFFD32F2F), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.delete_outline, size: 18), label: const Text('Hapus Data', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
            ElevatedButton.icon(onPressed: () { Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A3669), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.save_outlined, size: 18), label: const Text('Simpan Data', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}