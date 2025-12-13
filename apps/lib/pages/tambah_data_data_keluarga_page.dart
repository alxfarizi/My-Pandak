import 'package:flutter/material.dart';

class TambahDataKeluargaPage extends StatefulWidget {
  const TambahDataKeluargaPage({super.key});

  @override
  State<TambahDataKeluargaPage> createState() => _TambahDataKeluargaPageState();
}

class _TambahDataKeluargaPageState extends State<TambahDataKeluargaPage> {
  static const double _labelFontSize = 12;
  static const double _valueFontSize = 12;
  static const double _tableCellHeight = 28;
  static const double _labelWidth = 164;
  static const double _colonWidth = 18;
  static const double _rightGap = 10;
  static const EdgeInsets _sectionPadding = EdgeInsets.zero;
  static const Color _dotColor = Color(0xFFA0A0A0);
  static const String _fontFamily = 'Poppins';

  final TextEditingController _desaWismaController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _dusunController = TextEditingController();
  final TextEditingController _lingkunganController = TextEditingController();
  final TextEditingController _namaKepalaRumahTanggaController = TextEditingController();
  
  final TextEditingController _namaKrtPerkaranganController = TextEditingController();
  final TextEditingController _namaKrtIndustriController = TextEditingController();

  final TextEditingController _jumlahAnggotaController = TextEditingController();
  final TextEditingController _jumlahLakiController = TextEditingController();
  final TextEditingController _jumlahPerempuanController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();

  final TextEditingController _jumlahKkController = TextEditingController();
  final TextEditingController _balitaController = TextEditingController();
  final TextEditingController _pusController = TextEditingController();
  final TextEditingController _wusController = TextEditingController();
  final TextEditingController _butaController = TextEditingController();
  final TextEditingController _ibuHamilController = TextEditingController();
  final TextEditingController _ibuMenyusuiController = TextEditingController();
  final TextEditingController _lansiaController = TextEditingController();

  String? _lansiaKriteria; 
  String? _makananPokok; 
  String? _jambanKeluarga; 
  String? _sumberAir; 
  String? _tempatSampah; 
  String? _saluranAirLimbah; 
  final TextEditingController _jumlahJambanOrangController = TextEditingController();
  String? _menempelStikerP4k; 
  String? _kriteriaRumah; 
  String? _aktivitasUp2k; 
  final TextEditingController _jenisUsahaController = TextEditingController();
  String? _jenisUsahaPilihan; 
  String? _aktivitasKegiatanKesehatan; 

  int _balitaLaki = 0;
  int _balitaPerempuan = 0;
  int _pusLaki = 0;
  int _pusPerempuan = 0;
  int _wusLaki = 0;
  int _wusPerempuan = 0;
  int _butaLaki = 0;
  int _butaPerempuan = 0;
  int _ibuHamil = 0;
  int _ibuMenyusui = 0;
  int _lansiaLaki = 0;
  int _lansiaPerempuan = 0;
  int _berkebutuhanKhusus = 0;

  List<Map<String, dynamic>> _anggotaKeluarga = [];
  int _nextAnggotaId = 1;

  @override
  void dispose() {
    _desaWismaController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _dusunController.dispose();
    _lingkunganController.dispose();
    _namaKepalaRumahTanggaController.dispose();
    _namaKrtPerkaranganController.dispose();
    _namaKrtIndustriController.dispose();
    _jumlahAnggotaController.dispose();
    _jumlahLakiController.dispose();
    _jumlahPerempuanController.dispose();
    _jumlahKkController.dispose();
    _jumlahController.dispose();
    _balitaController.dispose();
    _pusController.dispose();
    _wusController.dispose();
    _butaController.dispose();
    _ibuHamilController.dispose();
    _ibuMenyusuiController.dispose();
    _lansiaController.dispose();
    _jumlahJambanOrangController.dispose();
    _jenisUsahaController.dispose();
    super.dispose();
  }

  Widget _buildTwoColRow({
    required String label,
    required Widget right,
    double labelTopOffset = 0,
    CrossAxisAlignment rowAlign = CrossAxisAlignment.center,
    bool showColon = true,
  }) {
    return Row(
      crossAxisAlignment: rowAlign,
      children: [
        SizedBox(
          width: _labelWidth,
          child: Padding(
            padding: EdgeInsets.only(top: labelTopOffset),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: _fontFamily,
              ),
            ),
          ),
        ),
        SizedBox(
          width: _colonWidth,
          child: Padding(
            padding: EdgeInsets.only(top: labelTopOffset),
            child: showColon
                ? const Text(
                    ':',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _labelFontSize,
                      color: Colors.black,
                      fontFamily: _fontFamily,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: _rightGap),
        Expanded(child: right),
      ],
    );
  }

  Widget _indented(Widget child, {double left = 24}) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: child,
    );
  }

  Widget _dottedUnderline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dotWidth = 3;
        const double spacing = 4;
        final int count = (constraints.maxWidth / (dotWidth + spacing)).floor();
        return Row(
          children: List.generate(count, (index) {
            return Container(
              width: dotWidth,
              height: 1,
              margin: const EdgeInsets.only(right: spacing),
              color: _dotColor,
            );
          }),
        );
      },
    );
  }

  Widget _buildDottedInput(String label, TextEditingController controller,
      {String? placeholder}) {
    return _buildTwoColRow(
      label: label,
      labelTopOffset: 0,
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder ?? '',
              hintStyle:
                  const TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
          ),
          _dottedUnderline(),
        ],
      ),
    );
  }

  Widget _buildCheckboxGroup(
    String label,
    List<String> options,
    String? value,
    Function(String?) onChanged, {
    CrossAxisAlignment rowAlign = CrossAxisAlignment.center,
    bool showColon = true,
  }) {
    return _buildTwoColRow(
      label: label,
      right: Wrap(
        spacing: 12,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: options.map((option) {
          final selected = value == option;
          return InkWell(
            onTap: () => onChanged(selected ? null : option),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    child: selected
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 6),
                  Text(option, style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      rowAlign: rowAlign,
      showColon: showColon,
    );
  }

  Widget _checkboxOptionsInline(
    List<String> options,
    String? value,
    Function(String?) onChanged,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: options.map((option) {
        final selected = value == option;
        return InkWell(
          onTap: () => onChanged(selected ? null : option),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                  child: selected
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 6),
                Text(option, style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
                const SizedBox(width: 8),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCountWithUnit(String label, TextEditingController controller, String unit) {
    return _buildTwoColRow(
      label: label,
      right: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '...',
                    hintStyle: const TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(unit, style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
        ],
      ),
    );
  }

  Widget _inlineNumber(TextEditingController controller) {
    return SizedBox(
      width: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '1',
              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
              border: InputBorder.none,
              isDense: true,
            ),
            style: const TextStyle(fontSize: _valueFontSize),
            textAlign: TextAlign.center,
          ),
          _dottedUnderline(),
        ],
      ),
    );
  }

  Widget _inlineLabeledCount(String label, TextEditingController controller, String unit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(builder: (context) {
          final lower = label.toLowerCase();
          final isShort = label.length <= 10 || lower.contains('wus') || lower.contains('buta') || lower.contains('plus');
          final double labelFont = isShort ? 11 : 10;
          return Text(label, style: TextStyle(fontSize: labelFont, fontFamily: _fontFamily));
        }),
        const SizedBox(width: 3),
        const Text(':', style: TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
        const SizedBox(width: 3),
        SizedBox(
          width: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '....',
                  hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
                textAlign: TextAlign.center,
              ),
              _dottedUnderline(),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(unit, style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
      ],
    );
  }

  Widget _inlineCount(TextEditingController controller, String unit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '....',
                  hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize, fontFamily: _fontFamily),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
                textAlign: TextAlign.center,
              ),
              _dottedUnderline(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(unit, style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
      ],
    );
  }

  Widget _buildVerticalCounter(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w400, fontFamily: _fontFamily),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: InkWell(
                onTap: () => onChanged(value > 0 ? value - 1 : 0),
                child: const Center(
                  child: Text('-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: InkWell(
                onTap: () => onChanged(value + 1),
                child: const Center(
                  child: Text('+', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _tambahAnggotaKeluarga() {
    setState(() {
      _anggotaKeluarga.add({
        'id': _nextAnggotaId++,
        'no': _anggotaKeluarga.length + 1,
        'noReg': '',
        'nama': '',
        'statusKeluarga': '',
        'statusPerkawinan': '',
        'jenisKelamin': '', 
        'tglUmur': '',
        'pendidikan': '',
        'pekerjaan': '',
      });
    });
  }

  void _hapusAnggotaKeluarga(int id) {
    setState(() {
      _anggotaKeluarga.removeWhere((anggota) => anggota['id'] == id);
      for (int i = 0; i < _anggotaKeluarga.length; i++) {
        _anggotaKeluarga[i]['no'] = i + 1;
      }
    });
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
          'Data Keluarga',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Padding(
              padding: _sectionPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDottedInput('Desa Wisma', _desaWismaController, placeholder: 'Masukan Desa Wisma'),
                  const SizedBox(height: 12),
                  _buildTwoColRow(
                    label: 'RT / RW',
                    right: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _rtController,
                                decoration: InputDecoration(
                                  hintText: 'RT',
                                  hintStyle: const TextStyle(color: _dotColor, fontSize: _valueFontSize),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: _valueFontSize),
                              ),
                              _dottedUnderline(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('/', style: TextStyle(fontSize: _valueFontSize)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _rwController,
                                decoration: InputDecoration(
                                  hintText: 'RW',
                                  hintStyle: const TextStyle(color: _dotColor, fontSize: _valueFontSize),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: _valueFontSize),
                              ),
                              _dottedUnderline(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTwoColRow(
                    label: 'Dusun / Lingk',
                    right: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _dusunController,
                                decoration: InputDecoration(
                                  hintText: 'Dusun',
                                  hintStyle: const TextStyle(color: _dotColor, fontSize: _valueFontSize),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: _valueFontSize),
                              ),
                              _dottedUnderline(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('/', style: TextStyle(fontSize: _valueFontSize)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _lingkunganController,
                                decoration: InputDecoration(
                                  hintText: 'Lingkungan',
                                  hintStyle: const TextStyle(color: _dotColor, fontSize: _valueFontSize),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: _valueFontSize),
                              ),
                              _dottedUnderline(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Desa pandak Kec Baturaden',
                      style: TextStyle(fontSize: _valueFontSize)),
                  const SizedBox(height: 4),
                  const Text('Kab. Banyumas Prov. Jawa Tengah',
                      style: TextStyle(fontSize: _valueFontSize)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildDottedInput('Nama Kepala Rumah Tangga', _namaKepalaRumahTanggaController, placeholder: 'Masukan Nama Kepala Rumah Tangga'),
            const SizedBox(height: 20),

            _buildTwoColRow(
              label: 'Jumlah Anggota Keluarga',
              right: Wrap(
                spacing: 16,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _inlineCount(_jumlahAnggotaController, 'Orang'),
                  _inlineLabeledCount('Laki-laki', _jumlahLakiController, 'Orang'),
                  _inlineLabeledCount('Perempuan', _jumlahPerempuanController, 'Orang'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _indented(_buildCountWithUnit('1. Jumlah KK', _jumlahKkController, 'KK')),
            const SizedBox(height: 8),
            _indented(_buildTwoColRow(
              label: '2. Jumlah',
              right: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _inlineLabeledCount('A). Balita', _balitaController, 'Anak'),
                          const SizedBox(height: 8),
                          _inlineLabeledCount('C). WUS', _wusController, 'Orang'),
                          const SizedBox(height: 8),
                          _inlineLabeledCount('E). Ibu Hamil', _ibuHamilController, 'Orang'),
                          const SizedBox(height: 8),
                          _inlineLabeledCount('G). Lansia', _lansiaController, 'Orang'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _inlineLabeledCount('B). Plus', _pusController, 'Pasang'),
                          const SizedBox(height: 8),
                          _inlineLabeledCount('D). Buta', _butaController, 'Orang'),
                          const SizedBox(height: 8),
                          _inlineLabeledCount('F). Ibu Menyusui', _ibuMenyusuiController, 'Orang'),
                          const SizedBox(height: 8),
                          _checkboxOptionsInline(
                            ['Fisik', 'Non Fisik'],
                            _lansiaKriteria,
                            (value) => setState(() => _lansiaKriteria = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20),

            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _tambahAnggotaKeluarga,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Tambah Anggota'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Total: ${_anggotaKeluarga.length} anggota',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 880,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: const Color(0xFFF5F5F5),
                      ),
                      child: Row(
                        children: [
                          const Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Text('NO', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: Text('NO. REG', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Nama Anggota', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Status Dlm Keluarga', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Status Dlm Perkawinan', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: Text('Jenis Kelamin', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Tgl. Lahir / Umur', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Pendidikan', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text('Pekerjaan', style: TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w600)))),
                        ],
                      ),
                    ),
                    if (_anggotaKeluarga.isEmpty)
                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black, width: 1),
                            right: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Belum menambahkan anggota',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontFamily: _fontFamily,
                            ),
                          ),
                        ),
                      ),
                    if (_anggotaKeluarga.isNotEmpty)
                      ..._anggotaKeluarga.map((anggota) => Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 1),
                          right: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Text(anggota['no'].toString(), style: const TextStyle(fontSize: _valueFontSize)))),
                          Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Nomor Registrasi',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['noReg'] = value,
                          ))),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Nama Anggota',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['nama'] = value,
                          ))),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Status Dlm Keluarga',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['statusKeluarga'] = value,
                          ))),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Status Dlm Perkawinan',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['statusPerkawinan'] = value,
                          ))),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              child: Wrap(
                                spacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => setState(() => anggota['jenisKelamin'] = anggota['jenisKelamin'] == 'L' ? null : 'L'),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 1),
                                            borderRadius: BorderRadius.circular(2),
                                            color: Colors.white,
                                          ),
                                          child: anggota['jenisKelamin'] == 'L'
                                              ? Center(
                                                  child: Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2)),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text('L', style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => setState(() => anggota['jenisKelamin'] = anggota['jenisKelamin'] == 'P' ? null : 'P'),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 1),
                                            borderRadius: BorderRadius.circular(2),
                                            color: Colors.white,
                                          ),
                                          child: anggota['jenisKelamin'] == 'P'
                                              ? Center(
                                                  child: Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2)),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text('P', style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Tgl. Lahir / Umur',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['tglUmur'] = value,
                          ))),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Pendidikan',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['pendidikan'] = value,
                          ))),
                          Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Pekerjaan',
                              hintStyle: TextStyle(color: _dotColor, fontSize: _valueFontSize),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: _valueFontSize),
                            onChanged: (value) => anggota['pekerjaan'] = value,
                          ))),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () => _hapusAnggotaKeluarga(anggota['id']),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Status Dalam Keluarga : Suami, Istri, Anak, Menantu, Keluarga, Dll',
              style: TextStyle(fontSize: _valueFontSize),
            ),
            const SizedBox(height: 20),

            _indented(_buildCheckboxGroup(
              '3. Makanan Pokok Sehari-hari',
              ['Beras', 'Non Beras'],
              _makananPokok,
              (v) => setState(() => _makananPokok = v),
            )),
            const SizedBox(height: 12),
            _indented(_buildTwoColRow(
              label: '4. Mempunyai Jamban Keluarga',
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _jambanKeluarga = _jambanKeluarga == 'Ya' ? null : 'Ya'),
                        child: Row(children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: _jambanKeluarga == 'Ya'
                                ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2))))
                                : null,
                          ),
                          const SizedBox(width: 6),
                          const Text('Ya', style: TextStyle(fontSize: _valueFontSize)),
                        ]),
                      ),
                      InkWell(
                        onTap: () => setState(() => _jambanKeluarga = _jambanKeluarga == 'Tidak' ? null : 'Tidak'),
                        child: Row(children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: _jambanKeluarga == 'Tidak'
                                ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2))))
                                : null,
                          ),
                          const SizedBox(width: 6),
                          const Text('Tidak', style: TextStyle(fontSize: _valueFontSize)),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Jumlah : ', style: TextStyle(fontSize: _valueFontSize)),
                      _inlineNumber(_jumlahJambanOrangController),
                      const SizedBox(width: 4),
                      const Text('Orang', style: TextStyle(fontSize: _valueFontSize)),
                    ],
                  ),
                ],
              ),
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '5. Sumber Air Keluarga',
              ['PDAM', 'Sumur', 'Lainnya'],
              _sumberAir,
              (v) => setState(() => _sumberAir = v),
              rowAlign: CrossAxisAlignment.start,
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '6. Memiliki Tempat Pembuangan Sampah',
              ['Ya', 'Tidak'],
              _tempatSampah,
              (v) => setState(() => _tempatSampah = v),
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '7. Mempunyai Saluran Pembuangan Air Limbah',
              ['Ya', 'Tidak'],
              _saluranAirLimbah,
              (v) => setState(() => _saluranAirLimbah = v),
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '8. Menempel Stiker P4K',
              ['Ya', 'Tidak'],
              _menempelStikerP4k,
              (v) => setState(() => _menempelStikerP4k = v),
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '9. Kriteria Rumah',
              ['Ya', 'Tidak'],
              _kriteriaRumah,
              (v) => setState(() => _kriteriaRumah = v),
            )),
            const SizedBox(height: 12),
            _indented(_buildTwoColRow(
              label: '10. Aktivitas UP2K',
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _aktivitasUp2k = _aktivitasUp2k == 'Ya' ? null : 'Ya'),
                        child: Row(children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: _aktivitasUp2k == 'Ya'
                                ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2))))
                                : null,
                          ),
                          const SizedBox(width: 6),
                          const Text('Ya', style: TextStyle(fontSize: _valueFontSize)),
                        ]),
                      ),
                      InkWell(
                        onTap: () => setState(() => _aktivitasUp2k = _aktivitasUp2k == 'Tidak' ? null : 'Tidak'),
                        child: Row(children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: _aktivitasUp2k == 'Tidak'
                                ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2))))
                                : null,
                          ),
                          const SizedBox(width: 6),
                          const Text('Tidak', style: TextStyle(fontSize: _valueFontSize)),
                        ]),
                      ),
                    ],
                  ),
                  if (_aktivitasUp2k == 'Ya') ...[
                    const SizedBox(height: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jenis Usaha',
                          style: TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
                        ),
                        const SizedBox(height: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => setState(() => _jenisUsahaPilihan = _jenisUsahaPilihan == 'Warung' ? null : 'Warung'),
                              borderRadius: BorderRadius.circular(4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white,
                                      ),
                                      child: _jenisUsahaPilihan == 'Warung'
                                          ? Center(
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('Warung', style: TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () => setState(() => _jenisUsahaPilihan = _jenisUsahaPilihan == 'Kegiatan Koperasi' ? null : 'Kegiatan Koperasi'),
                              borderRadius: BorderRadius.circular(4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white,
                                      ),
                                      child: _jenisUsahaPilihan == 'Kegiatan Koperasi'
                                          ? Center(
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('Kegiatan Koperasi', style: TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            )),
            const SizedBox(height: 12),
            _indented(_buildCheckboxGroup(
              '11. Aktivitas Kegiatan Usaha Kesehatan Lingkungan',
              ['Layak', 'Tidak Layak'],
              _aktivitasKegiatanKesehatan,
              (v) => setState(() => _aktivitasKegiatanKesehatan = v),
            )),
            const SizedBox(height: 20),

            _SectionTitle('Pemanfaatan Tanah Perkarangan Hatinya PKK'),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Nama KRT',
              controller: _namaKrtPerkaranganController,
              placeholder: 'Masukan Nama KRT',
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                child: _EditableTable(
                  headers: const ['No', 'Keterangan', 'Komoditi', 'Volume'],
                  initialRows: 6,
                  presetKeterangan: const [
                    'Peternakan',
                    'Perikanan',
                    'Warung Hidup',
                    'Toga',
                    'Lumbung Hidup',
                    'Tanaman Keras',
                  ],
                  cellHeight: _tableCellHeight,
                ),
              ),
            ),
            const SizedBox(height: 24),

            _SectionTitle('Industri Keluarga'),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Nama KRT',
              controller: _namaKrtIndustriController,
              placeholder: 'Masukan Nama KRT',
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                child: _EditableTable(
                  headers: const ['No', 'Keterangan', 'Komoditi', 'Volume'],
                  initialRows: 4,
                  presetKeterangan: const [
                    'Pangan',
                    'Sandang',
                    'Jasa',
                    'Lain-lain',
                  ],
                  cellHeight: _tableCellHeight,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.delete_outline, size: 20),
                  label: const Text('Hapus Data'),
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C4A7C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.save_outlined, size: 20),
                  label: const Text('Simpan Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: _TambahDataKeluargaPageState._labelFontSize, fontWeight: FontWeight.w700),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  const _LabeledInput({
    required this.label,
    required this.controller,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: _TambahDataKeluargaPageState._labelFontSize),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: const TextStyle(
                    color: Color(0xFFA0A0A0),
                    fontSize: _TambahDataKeluargaPageState._valueFontSize,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
              ),
              LayoutBuilder(builder: (context, constraints) {
                const double dotWidth = 3;
                const double spacing = 4;
                final int count = (constraints.maxWidth / (dotWidth + spacing)).floor();
                return Row(
                  children: List.generate(count, (index) => Container(
                        width: dotWidth,
                        height: 1,
                        margin: const EdgeInsets.only(right: spacing),
                        color: const Color(0xFFA0A0A0),
                      )),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditableTable extends StatefulWidget {
  final List<String> headers;
  final int initialRows;
  final double cellHeight;
  final List<String>? presetKeterangan;
  final bool showJumlahRow;
  const _EditableTable({
    required this.headers,
    this.initialRows = 1,
    this.cellHeight = 28,
    this.presetKeterangan,
    this.showJumlahRow = true,
  });

  @override
  State<_EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends State<_EditableTable> {
  final List<_TableRowData> _rows = [];
  double _volumeTotal = 0;
  final TextEditingController _jumlahKomoditiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final int count = widget.presetKeterangan?.length ?? widget.initialRows;
    for (int i = 0; i < count; i++) {
      final row = _TableRowData();
      if (widget.presetKeterangan != null && i < widget.presetKeterangan!.length) {
        row.keterangan.text = widget.presetKeterangan![i];
      }
      row.volume.addListener(_recomputeVolume);
      _rows.add(row);
    }
    _recomputeVolume();
  }

  @override
  void dispose() {
    for (final r in _rows) {
      r.volume.removeListener(_recomputeVolume);
      r.dispose();
    }
    _jumlahKomoditiController.dispose();
    super.dispose();
  }

  void _recomputeVolume() {
    double total = 0;
    for (final r in _rows) {
      final String t = r.volume.text.trim();
      if (t.isEmpty) continue;
      final double? v = double.tryParse(t.replaceAll(',', '.'));
      if (v != null) total += v;
    }
    setState(() => _volumeTotal = total);
  }

  Widget _cell({required Widget child, bool isHeader = false, bool isReadonly = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
      ),
      height: widget.cellHeight,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.centerLeft,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: _TambahDataKeluargaPageState._valueFontSize,
          fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400,
          color: Colors.black,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _cell(child: Text(widget.headers[0]), isHeader: true)),
            Expanded(flex: 3, child: _cell(child: Text(widget.headers[1]), isHeader: true)),
            Expanded(flex: 3, child: _cell(child: Text(widget.headers[2]), isHeader: true)),
            Expanded(flex: 2, child: _cell(child: Text(widget.headers[3]), isHeader: true)),
            const SizedBox(width: 40),
          ],
        ),
        ...List.generate(_rows.length, (index) {
          final r = _rows[index];
          return Row(
            children: [
              Expanded(child: _cell(child: Text('${index + 1}'))),
              Expanded(
                flex: 3,
                child: _cell(
                  isReadonly: widget.presetKeterangan != null,
                  child: (widget.presetKeterangan != null)
                      ? Text(
                          r.keterangan.text,
                          style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
                        )
                      : TextField(
                          controller: r.keterangan,
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
                        ),
                ),
              ),
              Expanded(
                flex: 3,
                child: _cell(
                  child: TextField(
                    controller: r.komoditi,
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                    style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: _cell(
                  child: TextField(
                    controller: r.volume,
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                    style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          );
        }),
        if (widget.showJumlahRow) Row(
          children: [
            Expanded(child: _cell(child: const Text('-'))),
            Expanded(
              flex: 3,
              child: _cell(
                child: const Text(
                  'Jumlah',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                isReadonly: true,
              ),
            ),
            Expanded(
              flex: 3,
              child: _cell(
                child: TextField(
                  controller: _jumlahKomoditiController,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  style: const TextStyle(fontSize: _TambahDataKeluargaPageState._valueFontSize),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _cell(child: Text('$_volumeTotal')),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ],
    );
  }
}

class _TableRowData {
  final TextEditingController keterangan = TextEditingController();
  final TextEditingController komoditi = TextEditingController();
  final TextEditingController volume = TextEditingController();

  void dispose() {
    keterangan.dispose();
    komoditi.dispose();
    volume.dispose();
  }
}