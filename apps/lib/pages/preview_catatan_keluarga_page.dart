import 'dart:convert';
import 'package:flutter/material.dart';

class PreviewCatatanKeluargaPage extends StatelessWidget {
  final Map<String, String> catatanData;

  static const double _paperWidthLandscape = 360;
  static const double _vspaceXS = 6;
  static const double _vspaceS = 8;
  static const double _labelWidth = 90;
  static const double _colonWidth = 6;
  static const double _afterColonSpacing = 6;
  static const String _font = 'Poppins';

  const PreviewCatatanKeluargaPage({super.key, required this.catatanData});

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
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.file_copy, color: Colors.white, size: 20),
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
                      fontFamily: _font,
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
                              fontFamily: _font,
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
                      child: _buildPageContent(),
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
                    '$pageIndex/1',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: _font,
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

  Widget _buildPageContent() {
    List<Map<String, String>> rows = [];
    if (catatanData['anggotaKeluarga'] != null &&
        catatanData['anggotaKeluarga']!.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(catatanData['anggotaKeluarga']!);
        rows = list
            .map(
              (e) => {
                'no': (e['no'] ?? '').toString(),
                'nama': (e['nama'] ?? '').toString(),
                'statusPerkawinan': (e['statusPerkawinan'] ?? '').toString(),
                'jenisKelamin': (e['jenisKelamin'] ?? '').toString(),
                'tempatLahir': (e['tempatLahir'] ?? '').toString(),
                'tglBlThn': (e['tglBlThn'] ?? '').toString(),
                'agama': (e['agama'] ?? '').toString(),
                'pendidikan': (e['pendidikan'] ?? '').toString(),
                'pekerjaan': (e['pekerjaan'] ?? '').toString(),
                'berkebutuhanKhusus': (e['berkebutuhanKhusus'] ?? '')
                    .toString(),
                'penghayatanPancasila': (e['penghayatanPancasila'] ?? '')
                    .toString(),
                'gotongRoyong': (e['gotongRoyong'] ?? '').toString(),
                'pendidikanKeterampilan': (e['pendidikanKeterampilan'] ?? '')
                    .toString(),
                'pengembanganKoperasi': (e['pengembanganKoperasi'] ?? '')
                    .toString(),
                'perencanaanSehat': (e['perencanaanSehat'] ?? '').toString(),
                'pangan': (e['pangan'] ?? '').toString(),
                'sandang': (e['sandang'] ?? '').toString(),
                'kesehatan': (e['kesehatan'] ?? '').toString(),
                'ket': (e['ket'] ?? '').toString(),
              },
            )
            .toList();
      } catch (_) {}
    }

    if (rows.isEmpty) {
      rows = [
        {
          'no': '1',
          'nama': '',
          'statusPerkawinan': '',
          'jenisKelamin': '',
          'tempatLahir': '',
          'tglBlThn': '',
          'agama': '',
          'pendidikan': '',
          'pekerjaan': '',
        },
        {
          'no': '2',
          'nama': '',
          'statusPerkawinan': '',
          'jenisKelamin': '',
          'tempatLahir': '',
          'tglBlThn': '',
          'agama': '',
          'pendidikan': '',
          'pekerjaan': '',
        },
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Catatan Keluarga',
              style: const TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w600,
                fontFamily: _font,
              ),
            ),
          ),
          SizedBox(height: _vspaceS),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _formRowDotted(
                      'Catatan Keluarga dari',
                      catatanData['catatanDari'] ?? catatanData['nama'] ?? '',
                    ),
                    SizedBox(height: _vspaceXS),
                    _formRowDotted(
                      'Anggota Kelompok Dasa Wisma',
                      catatanData['anggotaKelompok'] ??
                          catatanData['mawar'] ??
                          '',
                    ),
                    SizedBox(height: _vspaceXS),
                    _formRowDotted('Tahun', catatanData['tahun'] ?? ''),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _checkboxGroupPreview('Kriteria Rumah', [
                      'Sehat',
                      'Tidak',
                    ], catatanData['kriteriaRumah']),
                    SizedBox(height: _vspaceXS),
                    _jambanPreview(),
                    SizedBox(height: _vspaceXS),
                    _checkboxGroupPreview('Kesehatan', [
                      'Sehat',
                      'Sakit',
                    ], catatanData['kesehatan']),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _catatanTableHeader(),
          ...rows.map((r) => _catatanTableRow(r)).toList(),
        ],
      ),
    );
  }

  Widget _catatanTableHeader() {
    final labels = const [
      'No',
      'Nama Anggota\nKeluarga',
      'Status\nPerkawinan',
      'L/P',
      'Tempat\nLahir',
      'TGL/BL/TH\nLahir/Umur',
      'Agama',
      'Pendidikan',
      'Pekerjaan',
      'Berkebutuhan\nKhusus',
      'Penghayatan dan\npengamalan pancasila',
      'Gotong\nRoyong',
      'Pendidikan dan\nketerampilan',
      'Pengembangan kehidupan\nberkoperasi',
      'Perencanaan Sehat',
      'Pangan',
      'Sandang',
      'Kesehatan',
      'Ket',
    ];
    final flex = const [
      6,
      18,
      12,
      6,
      14,
      18,
      10,
      14,
      14,
      12,
      18,
      14,
      18,
      18,
      14,
      12,
      12,
      14,
      10,
    ];
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 18,
              decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
              child: Row(
                children: [
                  for (int i = 0; i < 9; i++)
                    Expanded(
                      flex: flex[i],
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: flex.sublist(9, 18).reduce((a, b) => a + b),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Kegiatan PKK yang diikuti',
                          style: TextStyle(
                            fontSize: 6,
                            fontWeight: FontWeight.w600,
                            fontFamily: _font,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: flex[18],
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < labels.length; i++)
                  Expanded(
                    flex: flex[i],
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          labels[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: _font,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                for (int i = 0; i < flex.length; i++)
                  Expanded(
                    flex: flex[i],
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          (i + 1).toString(),
                          style: const TextStyle(
                            fontSize: 5,
                            fontFamily: _font,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _catatanTableRow(Map<String, String> r) {
    final flex = const [
      6,
      18,
      12,
      6,
      14,
      18,
      10,
      14,
      14,
      12,
      18,
      14,
      18,
      18,
      14,
      12,
      12,
      14,
      10,
    ];
    final cells = [
      r['no'] ?? '-',
      r['nama'] ?? '',
      r['statusPerkawinan'] ?? '',
      r['jenisKelamin'] ?? '',
      r['tempatLahir'] ?? '',
      r['tglBlThn'] ?? '',
      r['agama'] ?? '',
      r['pendidikan'] ?? '',
      r['pekerjaan'] ?? '',
      r['berkebutuhanKhusus'] ?? '',
      r['penghayatanPancasila'] ?? '',
      r['gotongRoyong'] ?? '',
      r['pendidikanKeterampilan'] ?? '',
      r['pengembanganKoperasi'] ?? '',
      r['perencanaanSehat'] ?? '',
      r['pangan'] ?? '',
      r['sandang'] ?? '',
      r['kesehatan'] ?? '',
      r['ket'] ?? '',
    ];
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          for (int i = 0; i < flex.length; i++)
            Expanded(
              flex: flex[i],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Center(
                  child: Text(
                    cells[i],
                    style: const TextStyle(fontSize: 5, fontFamily: _font),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _formRowDotted(String label, String value) {
    return Row(
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
          child: value.isNotEmpty
              ? Text(
                  value,
                  style: const TextStyle(fontSize: 5, fontFamily: _font),
                )
              : _dottedUnderline(),
        ),
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

  Widget _checkboxGroupPreview(
    String label,
    List<String> options,
    String? selected,
  ) {
    return Row(
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

  Widget _jambanPreview() {
    final isYa = (catatanData['jambanKeluarga'] ?? '') == 'Ya';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: _labelWidth,
              child: const Text(
                'Jamban Keluarga',
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
                  _checkboxLabel('Ya', isYa),
                  _checkboxLabel(
                    'Tidak',
                    (catatanData['jambanKeluarga'] ?? '') == 'Tidak',
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isYa) ...[
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
                width: 45,
                child: (catatanData['jumlahJambanOrang'] ?? '').isNotEmpty
                    ? Center(
                        child: Text(
                          catatanData['jumlahJambanOrang']!,
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
}
