//preview_data_keluarga_page.dart - WITH REAL ANGGOTA (UPDATED)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/anggota_keluarga_controller.dart';
import '../data/models/anggota_keluarga.dart';

class PreviewDataKeluargaPage extends StatefulWidget {
  final Map<String, String> keluargaData;

  const PreviewDataKeluargaPage({super.key, required this.keluargaData});

  @override
  State<PreviewDataKeluargaPage> createState() => _PreviewDataKeluargaPageState();
}

class _PreviewDataKeluargaPageState extends State<PreviewDataKeluargaPage> {
  List<AnggotaKeluarga> anggotaList = [];
  bool isLoadingAnggota = true;

  static const double _labelWidth = 80;
  static const double _colonWidth = 1;
  static const double _afterColonSpacing = 5;
  static const double _paperWidthLandscape = 360;
  static const double _vspaceXS = 6;
  static const double _vspaceS = 8;
  static const double _numberWidth = 10;
  static const String _font = 'Poppins';

  @override
  void initState() {
    super.initState();
    _loadAnggotaData();
  }

// FIXED: Load real anggota data using keluarga ID
  Future<void> _loadAnggotaData() async {
    try {
      setState(() {
        isLoadingAnggota = true;
      });

      final keluargaIdStr = widget.keluargaData['id'] ?? '';
      if (keluargaIdStr.isNotEmpty) {
        final keluargaId = int.tryParse(keluargaIdStr);
        if (keluargaId != null) {
          final anggotaController = context.read<AnggotaKeluargaController>();

          // Load anggota by keluarga ID
          await anggotaController.loadAnggotaByKeluarga(keluargaId);
          anggotaList = anggotaController.anggotaByKeluarga;
        }
      }

      setState(() {
        isLoadingAnggota = false;
      });
    } catch (e) {
      setState(() {
        isLoadingAnggota = false;
      });
      print('Error loading anggota data: $e');
    }
  }

// Format tanggal lahir from AnggotaKeluarga
  String _formatTanggalLahir(AnggotaKeluarga anggota) {
    if (anggota.tanggalLahir != null) {
      final date = anggota.tanggalLahir!;
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
    if (anggota.umur != null) {
      return '${anggota.umur} tahun';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Simpan Sebagai PDF', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF2F4D8A), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 23),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 27),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Ukuran : A4', style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Poppins')),
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle),
                child: Stack(alignment: Alignment.center, children: const [
                  Icon(Icons.download, color: Colors.white, size: 20),
                  Positioned(bottom: 8, child: Text('Download', style: TextStyle(fontSize: 5, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Poppins'))),
                ]),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                _buildLandscapePaper(context, pageIndex: 1, child: _buildPaper1Content()),
                const SizedBox(height: 24),
                _buildLandscapePaper(context, pageIndex: 2, child: _buildPaper2Content()),
                const SizedBox(height: 24),
                _buildLandscapePaper(context, pageIndex: 3, child: _buildPaper3Content()),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPaper1Content() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(child: Text('Data Keluarga', style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: _font))),
      SizedBox(height: _vspaceS),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildFormRowDotted('Desa Wisma', widget.keluargaData['desaWisma'] ?? widget.keluargaData['mawar'] ?? ''),
          SizedBox(height: _vspaceXS),
          _buildFormRowDotted('Nama Kepala Rumah Tangga', widget.keluargaData['nama'] ?? ''),
          SizedBox(height: _vspaceXS),
          _buildFormRowDotted('Dusun / Lingk', _composeSlash(widget.keluargaData['dusun'], widget.keluargaData['lingkungan'])),
          SizedBox(height: _vspaceXS),
          _buildFormRowDotted('RT / RW', _composeSlash(widget.keluargaData['rt'], widget.keluargaData['rw'])),
          const SizedBox(height: 4),
          const Text('Desa Pandak Kec. Baturaden', style: TextStyle(fontSize: 5, fontFamily: _font)),
          const SizedBox(height: 2),
          const Text('Kab. Banyumas Prov. Jawa Tengah', style: TextStyle(fontSize: 5, fontFamily: _font)),
          SizedBox(height: _vspaceS),
          Row(children: [
            SizedBox(width: _labelWidth, child: const Text('Jumlah Anggota Keluarga', style: TextStyle(fontSize: 5, fontFamily: _font))),
            SizedBox(width: _colonWidth, child: const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font))),
            const SizedBox(width: _afterColonSpacing),
            Expanded(child: Wrap(spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
              _inlineCountPreview(widget.keluargaData['jumlahAnggota'], 'Orang'),
              _inlineLabeledCountPreview('Laki-laki', widget.keluargaData['jumlahLaki'], 'Orang'),
              _inlineLabeledCountPreview('Perempuan', widget.keluargaData['jumlahPerempuan'], 'Orang'),
            ])),
          ]),
          const SizedBox(height: 6),
          _buildFormRowDotted('1. Jumlah KK', widget.keluargaData['jumlahKk'] ?? ''),
          const SizedBox(height: 4),
          _buildJumlahSection(),
          const SizedBox(height: 6),
          _buildLandscapeTableHeader(),
          const SizedBox(height: 6),
          // FIXED: Use real anggota data from database
          if (isLoadingAnggota)
            const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Loading anggota data...', style: TextStyle(fontSize: 5, fontFamily: _font)),
            ))
          else if (anggotaList.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Tidak ada data anggota keluarga', style: TextStyle(fontSize: 5, fontFamily: _font)),
            ))
          else
            ...anggotaList.asMap().entries.map((entry) {
              final index = entry.key;
              final anggota = entry.value;

              // FIXED: Use real data from database
              return _buildLandscapeTableRow(
                anggota.nik ?? anggota.noRegistrasi ?? '', // Real NIK/No Reg
                anggota.nama, // Real nama
                anggota.statusDalamKeluarga ?? 'Anggota Keluarga', // Real status
                anggota.statusPerkawinan ?? 'Belum Kawin', // Real status perkawinan
                _formatTanggalLahir(anggota), // Real tanggal lahir/umur
                anggota.pendidikan ?? '', // Real pendidikan
                anggota.pekerjaan ?? '', // Real pekerjaan
                male: anggota.jenisKelamin == 'L', // Real jenis kelamin
                female: anggota.jenisKelamin == 'P', // Real jenis kelamin
              );
            }).toList(),
        ]),
      ),
    ]);
  }

// Rest of the methods remain the same...
  Widget _buildLandscapePaper(BuildContext context, {required int pageIndex, required Widget child}) {
    return Center(
      child: Container(
        width: _paperWidthLandscape,
        margin: const EdgeInsets.symmetric(horizontal: 45),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4, offset: Offset(0, 4))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: _vspaceS),
          child,
          SizedBox(height: _vspaceS),
          Container(
            color: const Color(0xFFA3A3A3),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('$pageIndex/3', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Poppins')),
              Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.check, color: Color(0xFFA3A3A3), size: 12)),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildPaper2Content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: _vspaceS),
        const SizedBox(height: 10),
        _buildCheckboxGroupPreview('3. Makanan Pokok Sehari-hari', ['Beras', 'Non Beras'], widget.keluargaData['makananPokok']),
        const SizedBox(height: 8),
        _buildJambanPreview(),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('5. Sumber Air Keluarga', ['PDAM', 'Sumur', 'Lainnya'], widget.keluargaData['sumberAir']),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('6. Memiliki Tempat Pembuangan Sampah', ['Ya', 'Tidak'], widget.keluargaData['tempatSampah']),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('7. Mempunyai Saluran Pembuangan Air Limbah', ['Ya', 'Tidak'], widget.keluargaData['saluranAirLimbah']),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('8. Menempel Stiker P4K', ['Ya', 'Tidak'], widget.keluargaData['menempelStikerP4k']),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('9. Kriteria Rumah', ['Ya', 'Tidak'], widget.keluargaData['kriteriaRumah']),
        const SizedBox(height: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildCheckboxGroupPreview('10. Aktivitas UP2K', ['Ya', 'Tidak'], widget.keluargaData['aktivitasUp2k']),
          const SizedBox(height: 6),
          if ((widget.keluargaData['aktivitasUp2k'] ?? '') == 'Ya') Row(children: [
            _checkboxLabel('Warung', (widget.keluargaData['jenisUsahaPilihan'] ?? '') == 'Warung'),
            const SizedBox(width: 12),
            _checkboxLabel('Kegiatan Koperasi', (widget.keluargaData['jenisUsahaPilihan'] ?? '') == 'Kegiatan Koperasi'),
          ]),
        ]),
        const SizedBox(height: 8),
        _buildCheckboxGroupPreview('11. Aktivitas Kegiatan Usaha Kesehatan Lingkungan', ['Layak', 'Tidak Layak'], widget.keluargaData['aktivitasKegiatanKesehatan']),
      ]),
    );
  }

  Widget _buildPaper3Content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: const [
          Expanded(child: Text('Pemanfaatan Tanah Perkarangan Hatinya PKK', style: TextStyle(fontSize: 7, fontWeight: FontWeight.w600, fontFamily: _font))),
          SizedBox(width: 12),
          Expanded(child: Text('Industri Keluarga', style: TextStyle(fontSize: 7, fontWeight: FontWeight.w600, fontFamily: _font))),
        ]),
        const SizedBox(height: 6),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: _buildMiniThreeTable(headers: const ['Keterangan', 'Komoditi', 'Volume'], rows: const [
            ['Peternakan', '', ''],
            ['Perikanan', '', ''],
            ['Warung Hidup', '', ''],
            ['Toga', '', ''],
            ['Lumbung Hidup', '', ''],
            ['Tanaman Keras', '', ''],
          ])),
          const SizedBox(width: 12),
          Expanded(child: _buildMiniThreeTable(headers: const ['Keterangan', 'Komoditi', 'Volume'], rows: const [
            ['Pangan', '', ''],
            ['Sandang', '', ''],
            ['Jasa', '', ''],
            ['Lain-lain', '', ''],
          ])),
        ]),
      ]),
    );
  }

  Widget _buildMiniThreeTable({required List<String> headers, required List<List<String>> rows}) {
    TextStyle header = const TextStyle(fontSize: 6, fontWeight: FontWeight.w600, fontFamily: _font);
    TextStyle cell = const TextStyle(fontSize: 6, fontFamily: _font);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFA3A3A3))),
      child: Column(children: [
        Container(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6), color: const Color(0xFFEFEFEF), child: Row(children: [
          Expanded(flex: 3, child: Text(headers[0], style: header)),
          Expanded(flex: 3, child: Text(headers[1], style: header)),
          Expanded(flex: 2, child: Text(headers[2], style: header)),
        ])),
        ...rows.map((r) => Container(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))), child: Row(children: [
          Expanded(flex: 3, child: Text(r[0], style: cell)),
          Expanded(flex: 3, child: Text(r[1], style: cell)),
          Expanded(flex: 2, child: Text(r[2], style: cell)),
        ]))),
      ]),
    );
  }

  Widget _buildLandscapeTableHeader() {
    TextStyle th = const TextStyle(fontSize: 5, fontWeight: FontWeight.w600, fontFamily: _font);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFA3A3A3))),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(children: [
        Expanded(flex: 13, child: Text('No. Reg', style: th)),
        Expanded(flex: 20, child: Text('Nama Anggota', style: th)),
        Expanded(flex: 18, child: Text('Status Dlm Keluarga', style: th)),
        Expanded(flex: 18, child: Text('Status Dlm Perkawinan', style: th)),
        Expanded(flex: 18, child: Text('Tgl. Lahir / Umur', style: th)),
        Expanded(flex: 15, child: Text('Pendidikan', style: th)),
        Expanded(flex: 15, child: Text('Pekerjaan', style: th)),
        const SizedBox(width: 6),
        const Text('L', style: TextStyle(fontSize: 5, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
        const SizedBox(width: 6),
        const Text('P', style: TextStyle(fontSize: 5, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
      ]),
    );
  }

  Widget _buildLandscapeTableRow(String noReg, String nama, String statusKeluarga, String statusKawin, String tglUmur, String pendidikan, String pekerjaan, {bool male = false, bool female = false}) {
    TextStyle td = const TextStyle(fontSize: 5, fontFamily: _font);
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(children: [
        Expanded(flex: 13, child: Text(noReg, style: td)),
        Expanded(flex: 20, child: Text(nama, style: td)),
        Expanded(flex: 18, child: Text(statusKeluarga, style: td)),
        Expanded(flex: 18, child: Text(statusKawin, style: td)),
        Expanded(flex: 18, child: Text(tglUmur, style: td)),
        Expanded(flex: 15, child: Text(pendidikan, style: td)),
        Expanded(flex: 15, child: Text(pekerjaan, style: td)),
        const SizedBox(width: 6),
        _tinyCheck(male),
        const SizedBox(width: 12),
        _tinyCheck(female),
      ]),
    );
  }

  Widget _tinyCheck(bool checked) {
    return Container(width: 8, height: 8, decoration: BoxDecoration(border: Border.all(color: const Color(0xFFA3A3A3)), color: checked ? const Color(0xFFA3A3A3) : Colors.white));
  }

  Widget _buildFormRowDotted(String label, String value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(width: _labelWidth, child: Text(label, style: const TextStyle(fontSize: 5, color: Colors.black, fontFamily: _font))),
      SizedBox(width: _colonWidth, child: const Text(':', style: TextStyle(fontSize: 5, color: Colors.black, fontFamily: _font))),
      const SizedBox(width: _afterColonSpacing),
      Expanded(child: value.isNotEmpty ? Text(value, style: const TextStyle(fontSize: 5, color: Colors.black, fontFamily: _font)) : _dottedUnderline()),
    ]);
  }

  Widget _dottedUnderline() {
    return LayoutBuilder(builder: (context, constraints) {
      const double dotWidth = 3;
      const double spacing = 4;
      final int count = (constraints.maxWidth / (dotWidth + spacing)).floor();
      return Row(children: List.generate(count, (index) => Container(width: dotWidth, height: 1, margin: const EdgeInsets.only(right: spacing), color: const Color(0xFFA0A0A0))));
    });
  }

  String _composeSlash(String? left, String? right) {
    final l = (left ?? '').trim();
    final r = (right ?? '').trim();
    if (l.isEmpty && r.isEmpty) return '';
    if (l.isEmpty) return r;
    if (r.isEmpty) return l;
    return '$l / $r';
  }

  Widget _inlineCountPreview(String? value, String unit) {
    final v = (value ?? '').trim();
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 25, child: v.isNotEmpty ? Center(child: Text(v, style: const TextStyle(fontSize: 5, fontFamily: _font))) : _dottedUnderline()),
      const SizedBox(width: 4),
      Text(unit, style: const TextStyle(fontSize: 5, fontFamily: _font)),
    ]);
  }

  Widget _inlineLabeledCountPreview(String label, String? value, String unit) {
    final v = (value ?? '').trim();
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: const TextStyle(fontSize: 5, fontFamily: _font)),
      const SizedBox(width: 3),
      const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
      const SizedBox(width: 3),
      SizedBox(width: 25, child: v.isNotEmpty ? Center(child: Text(v, style: const TextStyle(fontSize: 5, fontFamily: _font))) : _dottedUnderline()),
      const SizedBox(width: 4),
      Text(unit, style: const TextStyle(fontSize: 5, fontFamily: _font)),
    ]);
  }

  Widget _checkboxLabel(String label, bool checked) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(2), color: Colors.white), child: checked ? Center(child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(1)))) : null),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 5, color: Colors.black, fontFamily: _font)),
    ]);
  }

  Widget _buildCheckboxGroupPreview(String label, List<String> options, String? selected) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(width: _labelWidth, child: Text(label, style: const TextStyle(fontSize: 5, fontFamily: _font))),
      SizedBox(width: _colonWidth, child: const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font))),
      const SizedBox(width: _afterColonSpacing),
      Expanded(child: Wrap(spacing: 12, runSpacing: 4, children: options.map((o) => _checkboxLabel(o, selected == o)).toList())),
    ]);
  }

  Widget _buildJambanPreview() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        SizedBox(width: _labelWidth, child: const Text('4. Mempunyai Jamban Keluarga', style: TextStyle(fontSize: 5, fontFamily: _font))),
        SizedBox(width: _colonWidth, child: const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font))),
        const SizedBox(width: _afterColonSpacing),
        Expanded(child: Wrap(spacing: 12, runSpacing: 4, children: [
          _checkboxLabel('Ya', (widget.keluargaData['jambanKeluarga'] ?? '') == 'Ya'),
          _checkboxLabel('Tidak', (widget.keluargaData['jambanKeluarga'] ?? '') == 'Tidak'),
        ])),
      ]),
      const SizedBox(height: 4),
      Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('Jumlah', style: TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 3),
        const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 3),
        SizedBox(width: 25, child: (widget.keluargaData['jumlahJambanOrang'] ?? '').isNotEmpty ? Center(child: Text(widget.keluargaData['jumlahJambanOrang']!, style: const TextStyle(fontSize: 5, fontFamily: _font))) : _dottedUnderline()),
        const SizedBox(width: 4),
        const Text('Orang', style: TextStyle(fontSize: 5, fontFamily: _font)),
      ]),
    ]);
  }

  Widget _buildJumlahSection() {
    return Row(children: [
      SizedBox(width: _labelWidth, child: const Text('2. Jumlah', style: TextStyle(fontSize: 5, fontFamily: _font))),
      SizedBox(width: _colonWidth, child: const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font))),
      const SizedBox(width: _afterColonSpacing),
      Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _inlineLabeledCountPreview('A). Balita', widget.keluargaData['balita'], 'Anak'),
          const SizedBox(height: 6),
          _inlineLabeledCountPreview('C). WUS', widget.keluargaData['wus'], 'Orang'),
          const SizedBox(height: 6),
          _inlineLabeledCountPreview('E). Ibu Hamil', widget.keluargaData['ibuHamil'], 'Orang'),
          const SizedBox(height: 6),
          _inlineLabeledCountPreview('G). Lansia', widget.keluargaData['lansia'], 'Orang'),
        ])),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _inlineLabeledCountPreview('B). Plus', widget.keluargaData['pus'], 'Pasang'),
          const SizedBox(height: 6),
          _inlineLabeledCountPreview('D). Buta', widget.keluargaData['buta'], 'Orang'),
          const SizedBox(height: 6),
          _inlineLabeledCountPreview('F). Ibu Menyusui', widget.keluargaData['ibuMenyusui'], 'Orang'),
          const SizedBox(height: 6),
          Row(children: [
            _checkboxLabel('Fisik', widget.keluargaData['lansiaKriteria'] == 'Fisik'),
            const SizedBox(width: 12),
            _checkboxLabel('Non Fisik', widget.keluargaData['lansiaKriteria'] == 'Non Fisik'),
          ]),
        ])),
      ])),
    ]);
  }
}