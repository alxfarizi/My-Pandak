//preview_catatan_keluarga_page.dart - BORDER COLOR FIX
import 'package:flutter/material.dart';

class PreviewCatatanKeluargaPage extends StatelessWidget {
  final Map<String, String> catatanData;
  final List<Map<String, dynamic>>? anggotaData;

// Updated untuk landscape format
  static const double _paperWidthLandscape = 500;
  static const double _paperHeightLandscape = 350;
  static const double _vspaceXS = 6;
  static const double _vspaceS = 8;
  static const double _labelWidth = 90;
  static const double _colonWidth = 6;
  static const double _afterColonSpacing = 6;
  static const String _font = 'Poppins';

  const PreviewCatatanKeluargaPage({
    super.key,
    required this.catatanData,
    this.anggotaData,
  });

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ukuran : A4 Landscape',
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
        height: _paperHeightLandscape,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            const SizedBox(height: 8),
            Expanded(child: child),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Text(
              'Catatan Keluarga',
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                fontFamily: _font,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Info section - dibuat lebih compact untuk landscape
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use real data from catatanData
                    _formRowDotted(
                      'Catatan Keluarga dari',
                      catatanData['catatanDari'] ?? '',
                    ),
                    const SizedBox(height: 4),
                    _formRowDotted(
                      'Anggota Kelompok Dasa Wisma',
                      catatanData['anggotaKelompok'] ?? '',
                    ),
                    const SizedBox(height: 4),
                    _formRowDotted('Tahun', catatanData['tahun'] ?? ''),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use real data for checkboxes
                    _checkboxGroupPreview('Kriteria Rumah', [
                      'Sehat',
                      'Tidak Sehat',
                    ], catatanData['kriteriaRumah']),
                    const SizedBox(height: 4),
                    _checkboxGroupPreview('Tempat Sampah', [
                      'Ada',
                      'Tidak',
                    ], catatanData['tempatSampah']),
                    const SizedBox(height: 4),
                    _jambanPreview(),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Table section - optimized untuk landscape dengan data real
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 800,
                child: Column(
                  children: [
                    _catatanTableHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: _buildTableRows()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Build table rows from real anggota data
  List<Widget> _buildTableRows() {
    if (anggotaData == null || anggotaData!.isEmpty) {
      // Fallback to sample data if no real data available
      return [
        _catatanTableRow(
          _createRowData(
            1,
            'Susilo I.P',
            'Menikah',
            'L',
            'Banyumas',
            '21/10/1981',
            'Islam',
            'SMU',
            'Buruh',
          ),
        ),
        _catatanTableRow(
          _createRowData(
            2,
            'Reny B.L',
            'Menikah',
            'P',
            'Banyumas',
            '10/10/1984',
            'Islam',
            'SMK',
            'IRT',
          ),
        ),
        _catatanTableRow(
          _createRowData(
            3,
            'Neisya.R.',
            'Lajang',
            'P',
            'Banyumas',
            '02/06/2006',
            'Islam',
            'SMU',
            'Pelajar',
          ),
        ),
        _catatanTableRow(
          _createRowData(
            4,
            'Dafeena',
            'Lajang',
            'P',
            'Banyumas',
            '01/12/2021',
            'Islam',
            'Belum',
            'Belum',
          ),
        ),
      ];
    }

    // Use real anggota data
    return anggotaData!.asMap().entries.map((entry) {
      final index = entry.key;
      final anggota = entry.value;

      return _catatanTableRow(_createRowDataFromAnggota(index + 1, anggota));
    }).toList();
  }

// Create row data from real anggota object
  Map<String, String> _createRowDataFromAnggota(
      int no,
      Map<String, dynamic> anggota,
      ) {
    return {
      'no': '$no',
      'nama': anggota['nama']?.toString() ?? '',
      'statusPerkawinan': anggota['statusPerkawinan']?.toString() ?? '',
      'jenisKelamin': _formatJenisKelamin(anggota['jenisKelamin']?.toString()),
      'tempatLahir': anggota['tempatLahir']?.toString() ?? '',
      'tglBlThn': anggota['tglBlThn']?.toString() ?? '',
      'agama': anggota['agama']?.toString() ?? '',
      'pendidikan': anggota['pendidikan']?.toString() ?? '',
      'pekerjaan': anggota['pekerjaan']?.toString() ?? '',
      'berkebutuhanKhusus': anggota['berkebutuhanKhusus']?.toString() ?? '',
      'penghayatanPancasila': anggota['penghayatanPancasila']?.toString() ?? '',
      'gotongRoyong': anggota['gotongRoyong']?.toString() ?? '',
      'pendidikanKeterampilan':
      anggota['pendidikanKeterampilan']?.toString() ?? '',
      'pengembanganKoperasi': anggota['pengembanganKoperasi']?.toString() ?? '',
      'perencanaanSehat': anggota['perencanaanSehat']?.toString() ?? '',
      'pangan': anggota['pangan']?.toString() ?? '',
      'sandang': anggota['sandang']?.toString() ?? '',
      'kesehatan': anggota['kesehatan']?.toString() ?? '',
      'ket': anggota['ket']?.toString() ?? '',
    };
  }

// Helper method to format jenis kelamin
  String _formatJenisKelamin(String? jenisKelamin) {
    if (jenisKelamin == 'L') return 'L';
    if (jenisKelamin == 'P') return 'P';
    return jenisKelamin ?? '';
  }

// Fallback method for sample data
  Map<String, String> _createRowData(
      int no,
      String nama,
      String status,
      String lp,
      String tempat,
      String tgl,
      String agama,
      String pendidikan,
      String pekerjaan,
      ) {
    return {
      'no': '$no',
      'nama': nama,
      'statusPerkawinan': status,
      'jenisKelamin': lp,
      'tempatLahir': tempat,
      'tglBlThn': tgl,
      'agama': agama,
      'pendidikan': pendidikan,
      'pekerjaan': pekerjaan,
      'berkebutuhanKhusus': '',
      'penghayatanPancasila': '',
      'gotongRoyong': '',
      'pendidikanKeterampilan': '',
      'pengembanganKoperasi': '',
      'perencanaanSehat': '',
      'pangan': '',
      'sandang': '',
      'kesehatan': '',
      'ket': '',
    };
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

    // Optimized flex values untuk landscape
    final flex = const [
      4,
      12,
      10,
      4,
      10,
      12,
      8,
      10,
      10,
      10,
      14,
      10,
      14,
      16,
      12,
      8,
      8,
      10,
      6,
    ];

    return Column(
      children: [
        // Header grup untuk "Kegiatan PKK yang diikuti"
        Container(
          height: 16,
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          child: Row(
            children: [
              for (int i = 0; i < 9; i++)
                Expanded(
                  flex: flex[i],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  ),
                ),
              Expanded(
                flex: flex.sublist(9, 18).reduce((a, b) => a + b),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: const Center(
                    child: Text(
                      'Kegiatan PKK yang diikuti',
                      style: TextStyle(
                        fontSize: 5,
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
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Header kolom
        Container(
          height: 28,
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          child: Row(
            children: [
              for (int i = 0; i < labels.length; i++)
                Expanded(
                  flex: flex[i],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 4,
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
        ),

        // Nomor kolom
        Container(
          height: 14,
          child: Row(
            children: [
              for (int i = 0; i < flex.length; i++)
                Expanded(
                  flex: flex[i],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: const TextStyle(fontSize: 4, fontFamily: _font),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

// FIXED: Change border color from grey to black to match header
  Widget _catatanTableRow(Map<String, String> r) {
    final flex = const [
      4,
      12,
      10,
      4,
      10,
      12,
      8,
      10,
      10,
      10,
      14,
      10,
      14,
      16,
      12,
      8,
      8,
      10,
      6,
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
      height: 20,
      decoration: const BoxDecoration(
        border: Border(
          // FIXED: Change from grey to black to match header
          bottom: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < flex.length; i++)
            Expanded(
              flex: flex[i],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    // FIXED: Change from grey to black to match header
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    cells[i],
                    style: const TextStyle(fontSize: 4, fontFamily: _font),
                    textAlign: TextAlign.center,
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
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 4),
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
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(1),
            color: Colors.white,
          ),
          child: checked
              ? Center(
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          )
              : null,
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 4,
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
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontSize: 5, fontFamily: _font),
          ),
        ),
        const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
        const SizedBox(width: 4),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 2,
            children: options
                .map((o) => _checkboxLabel(o, selected == o))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _jambanPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 70,
              child: const Text(
                'Jamban Keluarga',
                style: TextStyle(fontSize: 5, fontFamily: _font),
              ),
            ),
            const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
            const SizedBox(width: 4),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 2,
                children: [
                  _checkboxLabel(
                    'Ya',
                    (catatanData['jambanKeluarga'] ?? '') == 'Ya',
                  ),
                  _checkboxLabel(
                    'Tidak',
                    (catatanData['jambanKeluarga'] ?? '') == 'Tidak',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Jumlah',
              style: TextStyle(fontSize: 5, fontFamily: _font),
            ),
            const SizedBox(width: 2),
            const Text(':', style: TextStyle(fontSize: 5, fontFamily: _font)),
            const SizedBox(width: 2),
            SizedBox(
              width: 30,
              child: (catatanData['jumlahJambanOrang'] ?? '').isNotEmpty
                  ? Center(
                child: Text(
                  catatanData['jumlahJambanOrang']!,
                  style: const TextStyle(fontSize: 5, fontFamily: _font),
                ),
              )
                  : _dottedUnderline(),
            ),
            const SizedBox(width: 3),
            const Text(
              'Orang',
              style: TextStyle(fontSize: 5, fontFamily: _font),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dottedUnderline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dotWidth = 2;
        const double spacing = 3;
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