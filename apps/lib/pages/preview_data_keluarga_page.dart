import 'package:flutter/material.dart';
import 'dart:convert';

class PreviewDataKeluargaPage extends StatelessWidget {
  final Map<String, String> keluargaData;

  static const double _labelWidth = 80;
  static const double _colonWidth = 1;
  static const double _afterColonSpacing = 5;
  static const double _paperWidthLandscape = 360;
  static const double _vspaceXS = 6;
  static const double _vspaceS = 8;
  static const double _numberWidth = 10;
  static const String _font = 'Poppins';

  const PreviewDataKeluargaPage({super.key, required this.keluargaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Simpan Sebagai PDF',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2F4D8A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 23),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ukuran : A4',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Icon(Icons.download, color: Colors.white, size: 20),
                        Positioned(
                          bottom: 8,
                          child: Text(
                            'Download',
                            style: TextStyle(
                              fontSize: 5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLandscapePaper(
                      context,
                      pageIndex: 1,
                      child: _buildPaper1Content(),
                    ),
                    const SizedBox(height: 24),
                    _buildLandscapePaper(
                      context,
                      pageIndex: 2,
                      child: _buildPaper2Content(),
                    ),
                    const SizedBox(height: 24),
                    _buildLandscapePaper(
                      context,
                      pageIndex: 3,
                      child: _buildPaper3Content(),
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

  Widget _buildLandscapePaper(
    BuildContext context, {
    required int pageIndex,
    required Widget child,
  }) {
    return Center(
      child: Container(
        width: _paperWidthLandscape,
        margin: const EdgeInsets.symmetric(horizontal: 45),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _vspaceS),
            child,
            SizedBox(height: _vspaceS),
            Container(
              color: const Color(0xFFA3A3A3),
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$pageIndex/3',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFFA3A3A3),
                      size: 12,
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

  Widget _paperTitle(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: _font,
        ),
      ),
    );
  }

  Widget _buildPaper1Content() {
    List<dynamic> anggota = [];
    if (keluargaData['anggotaKeluarga'] != null &&
        keluargaData['anggotaKeluarga']!.isNotEmpty) {
      try {
        anggota = jsonDecode(keluargaData['anggotaKeluarga']!);
      } catch (_) {}
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paperTitle('Data Keluarga'),
        SizedBox(height: _vspaceS),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormRowDotted(
                'Desa Wisma',
                keluargaData['desaWisma'] ?? keluargaData['mawar'] ?? '',
              ),
              SizedBox(height: _vspaceXS),
              _buildFormRowDotted(
                'Nama Kepala Rumah Tangga',
                keluargaData['nama'] ?? '',
              ),
              SizedBox(height: _vspaceXS),
              _buildFormRowDotted(
                'Dusun / Lingk',
                _composeSlash(
                  keluargaData['dusun'],
                  keluargaData['lingkungan'],
                ),
              ),
              SizedBox(height: _vspaceXS),
              _buildFormRowDotted(
                'RT / RW',
                _composeSlash(keluargaData['rt'], keluargaData['rw']),
              ),
              const SizedBox(height: 4),
              const Text(
                'Desa Pandak Kec. Baturaden',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
              const SizedBox(height: 2),
              const Text(
                'Kab. Banyumas Prov. Jawa Tengah',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
              SizedBox(height: _vspaceS),
              Row(
                children: [
                  SizedBox(
                    width: _labelWidth,
                    child: const Text(
                      'Jumlah Anggota Keluarga',
                      style: TextStyle(fontSize: 5, fontFamily: _font),
                    ),
                  ),
                  SizedBox(
                    width: _colonWidth,
                    child: const Text(
                      ':',
                      style: TextStyle(fontSize: 5, fontFamily: _font),
                    ),
                  ),
                  const SizedBox(width: _afterColonSpacing),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _inlineCountPreview(keluargaData['jumlah'], 'Orang'),
                        _inlineLabeledCountPreview(
                          'Laki-laki',
                          keluargaData['jumlahLaki'],
                          'Orang',
                        ),
                        _inlineLabeledCountPreview(
                          'Perempuan',
                          keluargaData['jumlahPerempuan'],
                          'Orang',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _buildFormRowDotted(
                '1. Jumlah KK',
                keluargaData['jumlahKk'] ?? '',
              ),
              const SizedBox(height: 4),
              _buildJumlahSection(),
              const SizedBox(height: 6),
              _buildLandscapeTableHeader(),
              const SizedBox(height: 6),
              if (anggota.isEmpty)
                const Text(
                  'Belum ada data anggota keluarga',
                  style: TextStyle(
                    fontSize: 5,
                    fontFamily: _font,
                    color: Colors.grey,
                  ),
                ),
              ...anggota.map(
                (a) => _buildLandscapeTableRow(
                  a['noReg'] ?? '',
                  a['nama'] ?? '',
                  a['statusKeluarga'] ?? '',
                  a['statusPerkawinan'] ?? '',
                  a['tglUmur'] ?? '',
                  a['pendidikan'] ?? '',
                  a['pekerjaan'] ?? '',
                  male: a['jenisKelamin'] == 'L',
                  female: a['jenisKelamin'] == 'P',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaper2Content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _vspaceS),
          const SizedBox(height: 10),
          _buildCheckboxGroupPreview('3. Makanan Pokok Sehari-hari', [
            'Beras',
            'Non Beras',
          ], keluargaData['makananPokok']),
          const SizedBox(height: 8),
          _buildJambanPreview(),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview('5. Sumber Air Keluarga', [
            'PDAM',
            'Sumur',
            'Lainnya',
          ], keluargaData['sumberAir']),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview('6. Memiliki Tempat Pembuangan Sampah', [
            'Ya',
            'Tidak',
          ], keluargaData['tempatSampah']),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview(
            '7. Mempunyai Saluran Pembuangan Air Limbah',
            ['Ya', 'Tidak'],
            keluargaData['saluranAirLimbah'],
          ),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview('8. Menempel Stiker P4K', [
            'Ya',
            'Tidak',
          ], keluargaData['menempelStikerP4k']),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview('9. Kriteria Rumah', [
            'Ya',
            'Tidak',
          ], keluargaData['kriteriaRumah']),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckboxGroupPreview('10. Aktivitas UP2K', [
                'Ya',
                'Tidak',
              ], keluargaData['aktivitasUp2k']),
              const SizedBox(height: 6),
              if ((keluargaData['aktivitasUp2k'] ?? '') == 'Ya')
                Row(
                  children: [
                    _checkboxLabel(
                      'Warung',
                      (keluargaData['jenisUsahaPilihan'] ?? '') == 'Warung',
                    ),
                    const SizedBox(width: 12),
                    _checkboxLabel(
                      'Kegiatan Koperasi',
                      (keluargaData['jenisUsahaPilihan'] ?? '') ==
                          'Kegiatan Koperasi',
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCheckboxGroupPreview(
            '11. Aktivitas Kegiatan Usaha Kesehatan Lingkungan',
            ['Layak', 'Tidak Layak'],
            keluargaData['aktivitasKesehatan'],
          ),
        ],
      ),
    );
  }

  Widget _buildPaper3Content() {
    List<List<String>> pemanfaatanRows = [];
    if (keluargaData['pemanfaatanTanah'] != null &&
        keluargaData['pemanfaatanTanah']!.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(
          keluargaData['pemanfaatanTanah']!,
        );
        pemanfaatanRows = list
            .map(
              (e) => [
                (e['keterangan'] ?? '').toString(),
                (e['komoditi'] ?? '').toString(),
                (e['volume'] ?? '').toString(),
              ],
            )
            .toList();
      } catch (_) {}
    }

    if (pemanfaatanRows.isEmpty) {
      pemanfaatanRows = [
        ['Peternakan', '', ''],
        ['Perikanan', '', ''],
        ['Warung Hidup', '', ''],
        ['Toga', '', ''],
        ['Lumbung Hidup', '', ''],
        ['Tanaman Keras', '', ''],
      ];
    }

    List<List<String>> industriRows = [];
    if (keluargaData['industriKeluarga'] != null &&
        keluargaData['industriKeluarga']!.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(
          keluargaData['industriKeluarga']!,
        );
        industriRows = list
            .map(
              (e) => [
                (e['keterangan'] ?? '').toString(),
                (e['komoditi'] ?? '').toString(),
                (e['volume'] ?? '').toString(),
              ],
            )
            .toList();
      } catch (_) {}
    }
    if (industriRows.isEmpty) {
      industriRows = [
        ['Pangan', '', ''],
        ['Sandang', '', ''],
        ['Jasa', '', ''],
        ['Lain-lain', '', ''],
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pemanfaatan Tanah Perkarangan Hatinya PKK',
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    fontFamily: _font,
                  ),
                ),
                const SizedBox(height: 4),
                _buildFormRowDotted(
                  'Nama KRT',
                  keluargaData['namaKrtPerkarangan'] ?? '',
                ),
                const SizedBox(height: 6),
                _buildMiniThreeTable(
                  headers: const ['Keterangan', 'Komoditi', 'Volume'],
                  rows: pemanfaatanRows,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Industri Keluarga',
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    fontFamily: _font,
                  ),
                ),
                const SizedBox(height: 4),
                _buildFormRowDotted(
                  'Nama KRT',
                  keluargaData['namaKrtIndustri'] ?? '',
                ),
                const SizedBox(height: 6),
                _buildMiniThreeTable(
                  headers: const ['Keterangan', 'Komoditi', 'Volume'],
                  rows: industriRows,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniThreeTable({
    required List<String> headers,
    required List<List<String>> rows,
  }) {
    TextStyle header = const TextStyle(
      fontSize: 6,
      fontWeight: FontWeight.w600,
      fontFamily: _font,
    );
    TextStyle cell = const TextStyle(fontSize: 6, fontFamily: _font);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFA3A3A3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            color: const Color(0xFFEFEFEF),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(headers[0], style: header)),
                Expanded(flex: 3, child: Text(headers[1], style: header)),
                Expanded(flex: 2, child: Text(headers[2], style: header)),
              ],
            ),
          ),
          ...rows.map(
            (r) => Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(r[0], style: cell)),
                  Expanded(flex: 3, child: Text(r[1], style: cell)),
                  Expanded(flex: 2, child: Text(r[2], style: cell)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistBlock(List<String> items) {
    return Wrap(
      runSpacing: 4,
      spacing: 12,
      children: items.map((i) => _buildCheckbox(i)).toList(),
    );
  }

  Widget _buildLandscapeTableHeader() {
    TextStyle th = const TextStyle(
      fontSize: 5,
      fontWeight: FontWeight.w600,
      fontFamily: _font,
    );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFA3A3A3)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(
        children: [
          Expanded(flex: 13, child: Text('No. Reg', style: th)),
          Expanded(flex: 20, child: Text('Nama Anggota', style: th)),
          Expanded(flex: 18, child: Text('Status Dlm Keluarga', style: th)),
          Expanded(flex: 18, child: Text('Status Dlm Perkawinan', style: th)),
          Expanded(flex: 18, child: Text('Tgl. Lahir / Umur', style: th)),
          Expanded(flex: 15, child: Text('Pendidikan', style: th)),
          Expanded(flex: 15, child: Text('Pekerjaan', style: th)),
          const SizedBox(width: 6),
          const Text(
            'L',
            style: TextStyle(
              fontSize: 5,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'P',
            style: TextStyle(
              fontSize: 5,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeTableRow(
    String noReg,
    String nama,
    String statusKeluarga,
    String statusKawin,
    String tglUmur,
    String pendidikan,
    String pekerjaan, {
    bool male = false,
    bool female = false,
  }) {
    TextStyle td = const TextStyle(fontSize: 5, fontFamily: _font);
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(
        children: [
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
        ],
      ),
    );
  }

  Widget _tinyCheck(bool checked) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFA3A3A3)),
        color: checked ? const Color(0xFFA3A3A3) : Colors.white,
      ),
    );
  }

  Widget _buildNumber(String txt) {
    return SizedBox(
      width: _numberWidth,
      child: Text(
        txt,
        style: const TextStyle(
          fontSize: 5,
          color: Colors.black,
          fontFamily: _font,
        ),
      ),
    );
  }

  Widget _buildFormRowDotted(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: _font,
            ),
          ),
        ),
        SizedBox(
          width: _colonWidth,
          child: const Text(
            ':',
            style: TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: _font,
            ),
          ),
        ),
        const SizedBox(width: _afterColonSpacing),
        Expanded(
          child: value.isNotEmpty
              ? Text(
                  value,
                  style: const TextStyle(
                    fontSize: 5,
                    color: Colors.black,
                    fontFamily: _font,
                  ),
                )
              : _dottedUnderline(),
        ),
      ],
    );
  }

  Widget _dottedUnderline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dotWidth = 3;
        const double spacing = 4;
        final int count = (constraints.maxWidth / (dotWidth + spacing)).floor();
        return Row(
          children: List.generate(
            count,
            (index) => Container(
              width: dotWidth,
              height: 1,
              margin: const EdgeInsets.only(right: spacing),
              color: const Color(0xFFA0A0A0),
            ),
          ),
        );
      },
    );
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 25,
          child: v.isNotEmpty
              ? Center(
                  child: Text(
                    v,
                    style: const TextStyle(fontSize: 5, fontFamily: _font),
                  ),
                )
              : _dottedUnderline(),
        ),
        const SizedBox(width: 4),
        Text(unit, style: const TextStyle(fontSize: 5, fontFamily: _font)),
      ],
    );
  }

  Widget _inlineLabeledCountPreview(String label, String? value, String unit) {
    final v = (value ?? '').trim();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 3),
        const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 3),
        SizedBox(
          width: 25,
          child: v.isNotEmpty
              ? Center(
                  child: Text(
                    v,
                    style: const TextStyle(fontSize: 5, fontFamily: _font),
                  ),
                )
              : _dottedUnderline(),
        ),
        const SizedBox(width: 4),
        Text(unit, style: const TextStyle(fontSize: 5, fontFamily: _font)),
      ],
    );
  }

  Widget _checkboxLabel(String label, bool checked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          child: checked
              ? Center(
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: _font,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxGroupPreview(
    String label,
    List<String> options,
    String? selected,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: const TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        SizedBox(
          width: _colonWidth,
          child: const Text(
            ':',
            style: TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        const SizedBox(width: _afterColonSpacing),
        Expanded(
          child: Wrap(
            spacing: 12,
            runSpacing: 4,
            children: options
                .map((o) => _checkboxLabel(o, selected == o))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildJambanPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: _labelWidth,
              child: const Text(
                '4. Mempunyai Jamban Keluarga',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
            ),
            SizedBox(
              width: _colonWidth,
              child: const Text(
                ':',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
            ),
            const SizedBox(width: _afterColonSpacing),
            Expanded(
              child: Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  _checkboxLabel(
                    'Ya',
                    (keluargaData['jambanKeluarga'] ?? '') == 'Ya',
                  ),
                  _checkboxLabel(
                    'Tidak',
                    (keluargaData['jambanKeluarga'] ?? '') == 'Tidak',
                  ),
                ],
              ),
            ),
          ],
        ),
        if ((keluargaData['jambanKeluarga'] ?? '') == 'Ya') ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Jumlah',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
              const SizedBox(width: 3),
              const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
              const SizedBox(width: 3),
              SizedBox(
                width: 25,
                child: (keluargaData['jumlahJamban'] ?? '').isNotEmpty
                    ? Center(
                        child: Text(
                          keluargaData['jumlahJamban']!,
                          style: const TextStyle(
                            fontSize: 5,
                            fontFamily: _font,
                          ),
                        ),
                      )
                    : _dottedUnderline(),
              ),
              const SizedBox(width: 4),
              const Text(
                'Orang',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildJumlahSection() {
    return Row(
      children: [
        SizedBox(
          width: _labelWidth,
          child: const Text(
            '2. Jumlah',
            style: TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        SizedBox(
          width: _colonWidth,
          child: const Text(
            ':',
            style: TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        const SizedBox(width: _afterColonSpacing),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _inlineLabeledCountPreview(
                      'A). Balita',
                      keluargaData['balita'],
                      'Anak',
                    ),
                    const SizedBox(height: 6),
                    _inlineLabeledCountPreview(
                      'C). WUS',
                      keluargaData['wus'],
                      'Orang',
                    ),
                    const SizedBox(height: 6),
                    _inlineLabeledCountPreview(
                      'E). Ibu Hamil',
                      keluargaData['ibuHamil'],
                      'Orang',
                    ),
                    const SizedBox(height: 6),
                    _inlineLabeledCountPreview(
                      'G). Lansia',
                      keluargaData['lansia'],
                      'Orang',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _inlineLabeledCountPreview(
                      'B). Plus',
                      keluargaData['pus'],
                      'Pasang',
                    ),
                    const SizedBox(height: 6),
                    _inlineLabeledCountPreview(
                      'D). Buta',
                      keluargaData['buta'],
                      'Orang',
                    ),
                    const SizedBox(height: 6),
                    _inlineLabeledCountPreview(
                      'F). Ibu Menyusui',
                      keluargaData['ibuMenyusui'],
                      'Orang',
                    ),
                    const SizedBox(height: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'H). Berkebutuhan Khusus :',
                          style: TextStyle(fontSize: 5, fontFamily: _font),
                        ),
                        const SizedBox(height: 2),
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: ['Fisik', 'Non Fisik']
                              .map(
                                (o) => _checkboxLabel(
                                  o,
                                  keluargaData['berkebutuhanKhusus'] == o,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
