import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/catatan_controller.dart';
import '../data/models/catatan.dart';

class TambahDataCatatanKeluargaPage extends StatefulWidget {
  final Catatan? initial;
  const TambahDataCatatanKeluargaPage({super.key, this.initial});

  @override
  State<TambahDataCatatanKeluargaPage> createState() =>
      _TambahDataCatatanKeluargaPageState();
}

class _AnggotaRowData {
  int id;
  int no;
  final TextEditingController nama = TextEditingController();
  final TextEditingController statusPerkawinan = TextEditingController();
  final TextEditingController jenisKelamin = TextEditingController();
  final TextEditingController tempatLahir = TextEditingController();
  final TextEditingController tglBlThn = TextEditingController();
  final TextEditingController agama = TextEditingController();
  final TextEditingController pendidikan = TextEditingController();
  final TextEditingController pekerjaan = TextEditingController();
  final TextEditingController berkebutuhanKhusus = TextEditingController();
  final TextEditingController penghayatanPancasila = TextEditingController();
  final TextEditingController gotongRoyong = TextEditingController();
  final TextEditingController pendidikanKeterampilan = TextEditingController();
  final TextEditingController pengembanganKoperasi = TextEditingController();
  final TextEditingController perencanaanSehat = TextEditingController();
  final TextEditingController pangan = TextEditingController();
  final TextEditingController sandang = TextEditingController();
  final TextEditingController kesehatan = TextEditingController();
  final TextEditingController ket = TextEditingController();

  _AnggotaRowData({required this.id, required this.no});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'no': no,
      'nama': nama.text,
      'statusPerkawinan': statusPerkawinan.text,
      'jenisKelamin': jenisKelamin.text,
      'tempatLahir': tempatLahir.text,
      'tglBlThn': tglBlThn.text,
      'agama': agama.text,
      'pendidikan': pendidikan.text,
      'pekerjaan': pekerjaan.text,
      'berkebutuhanKhusus': berkebutuhanKhusus.text,
      'penghayatanPancasila': penghayatanPancasila.text,
      'gotongRoyong': gotongRoyong.text,
      'pendidikanKeterampilan': pendidikanKeterampilan.text,
      'pengembanganKoperasi': pengembanganKoperasi.text,
      'perencanaanSehat': perencanaanSehat.text,
      'pangan': pangan.text,
      'sandang': sandang.text,
      'kesehatan': kesehatan.text,
      'ket': ket.text,
    };
  }

  void dispose() {
    nama.dispose();
    statusPerkawinan.dispose();
    jenisKelamin.dispose();
    tempatLahir.dispose();
    tglBlThn.dispose();
    agama.dispose();
    pendidikan.dispose();
    pekerjaan.dispose();
    berkebutuhanKhusus.dispose();
    penghayatanPancasila.dispose();
    gotongRoyong.dispose();
    pendidikanKeterampilan.dispose();
    pengembanganKoperasi.dispose();
    perencanaanSehat.dispose();
    pangan.dispose();
    sandang.dispose();
    kesehatan.dispose();
    ket.dispose();
  }
}

class _TambahDataCatatanKeluargaPageState
    extends State<TambahDataCatatanKeluargaPage> {
  static const double _labelFontSize = 12;
  static const double _valueFontSize = 12;
  static const double _tableCellHeight = 28;
  static const double _labelWidth = 164;
  static const double _colonWidth = 18;
  static const double _rightGap = 10;
  static const Color _dotColor = Color(0xFFA0A0A0);
  static const String _fontFamily = 'Poppins';
  static const double _gapSmall = 8;
  static const double _gapMedium = 10;
  final CatatanController _controller = CatatanController();

  static const List<double> _colWidths = [
    60,
    240,
    190,
    70,
    190,
    190,
    120,
    140,
    160,
    170,
    240,
    190,
    260,
    280,
    220,
    130,
    130,
    160,
    130,
  ];
  static const List<String> _colLabels = [
    'No',
    'Nama Anggota\nKeluarga',
    'Status\nPerkawinan',
    'L/P',
    'Tempat Lahir',
    'TGL / BL / TL\nLahir / Umur',
    'Agama',
    'Pendidikan',
    'Pekerjaan',
    'Berkebutuhan\nKhusus',
    'Penghayatan Dengan\nPengamalan Pancasila',
    'Gotong Royong',
    'Pendidikan dan\nketerampilan',
    'Pengembangan Kehidupan\nBerkoperasi',
    'Perencanaan Sehat',
    'Pangan',
    'Sandang',
    'Kesehatan',
    'Ket',
  ];

  final TextEditingController _desaWismaController = TextEditingController();
  final TextEditingController _anggotaKeluargaController =
      TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
  final TextEditingController _jumlahJambanOrangController =
      TextEditingController();
  String? _kesehatan;
  String? _jambanKeluarga;
  String? _kriteriaRumah;

  final List<_AnggotaRowData> _anggotaKeluarga = [];
  int _nextAnggotaId = 1;
  List<int> get _colFlex => _colWidths.map((w) => w.round()).toList();

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      _desaWismaController.text = widget.initial!.mawar;
      _anggotaKeluargaController.text = widget.initial!.nama;
      _kriteriaRumah = widget.initial!.kriteriaRumah;
      _jambanKeluarga = widget.initial!.jambanKeluarga;
      _jumlahJambanOrangController.text =
          widget.initial!.jumlahJambanOrang ?? '';
      _kesehatan = widget.initial!.kesehatan;

      if (widget.initial!.anggotaKeluarga != null) {
        try {
          final List<dynamic> list = jsonDecode(
            widget.initial!.anggotaKeluarga!,
          );
          for (var i = 0; i < list.length; i++) {
            final map = list[i];
            final row = _AnggotaRowData(id: _nextAnggotaId++, no: i + 1);
            row.nama.text = map['nama'] ?? '';
            row.statusPerkawinan.text = map['statusPerkawinan'] ?? '';
            row.jenisKelamin.text = map['jenisKelamin'] ?? '';
            row.tempatLahir.text = map['tempatLahir'] ?? '';
            row.tglBlThn.text = map['tglBlThn'] ?? '';
            row.agama.text = map['agama'] ?? '';
            row.pendidikan.text = map['pendidikan'] ?? '';
            row.pekerjaan.text = map['pekerjaan'] ?? '';
            row.berkebutuhanKhusus.text = map['berkebutuhanKhusus'] ?? '';
            row.penghayatanPancasila.text = map['penghayatanPancasila'] ?? '';
            row.gotongRoyong.text = map['gotongRoyong'] ?? '';
            row.pendidikanKeterampilan.text =
                map['pendidikanKeterampilan'] ?? '';
            row.pengembanganKoperasi.text = map['pengembanganKoperasi'] ?? '';
            row.perencanaanSehat.text = map['perencanaanSehat'] ?? '';
            row.pangan.text = map['pangan'] ?? '';
            row.sandang.text = map['sandang'] ?? '';
            row.kesehatan.text = map['kesehatan'] ?? '';
            row.ket.text = map['ket'] ?? '';
            _anggotaKeluarga.add(row);
          }
        } catch (e) {
          debugPrint('Error parsing anggotaKeluarga: $e');
        }
      }
    }
  }

  @override
  void dispose() {
    _desaWismaController.dispose();
    _anggotaKeluargaController.dispose();
    _tahunController.dispose();
    _jumlahJambanOrangController.dispose();
    for (var row in _anggotaKeluarga) {
      row.dispose();
    }
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

  Widget _inlineNumber(TextEditingController controller) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 2),
          border: UnderlineInputBorder(),
        ),
        style: const TextStyle(
          fontSize: _valueFontSize,
          fontFamily: _fontFamily,
        ),
        textAlign: TextAlign.center,
      ),
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

  Widget _buildDottedInput(
    String label,
    TextEditingController controller, {
    String? placeholder,
  }) {
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
              hintStyle: const TextStyle(
                color: _dotColor,
                fontSize: _valueFontSize,
                fontFamily: _fontFamily,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            style: const TextStyle(
              fontSize: _valueFontSize,
              fontFamily: _fontFamily,
            ),
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
                  Text(
                    option,
                    style: const TextStyle(
                      fontSize: _valueFontSize,
                      fontFamily: _fontFamily,
                    ),
                  ),
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

  void _tambahAnggotaKeluarga() {
    setState(() {
      _anggotaKeluarga.add(
        _AnggotaRowData(id: _nextAnggotaId++, no: _anggotaKeluarga.length + 1),
      );
    });
  }

  void _hapusAnggotaKeluarga(int id) {
    setState(() {
      _anggotaKeluarga.removeWhere((anggota) => anggota.id == id);
      for (int i = 0; i < _anggotaKeluarga.length; i++) {
        _anggotaKeluarga[i].no = i + 1;
      }
    });
  }

  Widget _buildTableHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24,
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          child: Row(
            children: [
              for (int i = 0; i < 11; i++)
                Expanded(
                  flex: _colFlex[i],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              Expanded(
                flex: _colFlex.sublist(11, 18).reduce((a, b) => a + b),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: const Center(
                    child: Text(
                      'Kegiatan PKK yang diikuti',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: _fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: _colFlex[18],
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
            for (int i = 0; i < _colLabels.length; i++)
              Expanded(
                flex: _colFlex[i],
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      _colLabels[i],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: _fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: [
            for (int i = 0; i < _colFlex.length; i++)
              Expanded(
                flex: _colFlex[i],
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      (i + 1).toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: _fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableRow(_AnggotaRowData anggota, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: index % 2 == 0 ? Colors.white : const Color(0xFFF5F5F5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: _colFlex[0],
            child: _buildTableCell(anggota.no.toString()),
          ),
          Expanded(flex: _colFlex[1], child: _buildEditableCell(anggota.nama)),
          Expanded(
            flex: _colFlex[2],
            child: _buildEditableCell(anggota.statusPerkawinan),
          ),
          Expanded(
            flex: _colFlex[3],
            child: _buildEditableCell(anggota.jenisKelamin),
          ),
          Expanded(
            flex: _colFlex[4],
            child: _buildEditableCell(anggota.tempatLahir),
          ),
          Expanded(
            flex: _colFlex[5],
            child: _buildEditableCell(anggota.tglBlThn),
          ),
          Expanded(flex: _colFlex[6], child: _buildEditableCell(anggota.agama)),
          Expanded(
            flex: _colFlex[7],
            child: _buildEditableCell(anggota.pendidikan),
          ),
          Expanded(
            flex: _colFlex[8],
            child: _buildEditableCell(anggota.pekerjaan),
          ),
          Expanded(
            flex: _colFlex[9],
            child: _buildEditableCell(anggota.berkebutuhanKhusus),
          ),
          Expanded(
            flex: _colFlex[10],
            child: _buildEditableCell(anggota.penghayatanPancasila),
          ),
          Expanded(
            flex: _colFlex[11],
            child: _buildEditableCell(anggota.gotongRoyong),
          ),
          Expanded(
            flex: _colFlex[12],
            child: _buildEditableCell(anggota.pendidikanKeterampilan),
          ),
          Expanded(
            flex: _colFlex[13],
            child: _buildEditableCell(anggota.pengembanganKoperasi),
          ),
          Expanded(
            flex: _colFlex[14],
            child: _buildEditableCell(anggota.perencanaanSehat),
          ),
          Expanded(
            flex: _colFlex[15],
            child: _buildEditableCell(anggota.pangan),
          ),
          Expanded(
            flex: _colFlex[16],
            child: _buildEditableCell(anggota.sandang),
          ),
          Expanded(
            flex: _colFlex[17],
            child: _buildEditableCell(anggota.kesehatan),
          ),
          Expanded(
            flex: _colFlex[18],
            child: _buildEditableCellWithDelete(anggota.ket, id: anggota.id),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      height: _tableCellHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontFamily: _fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildEditableCell(TextEditingController controller) {
    return Container(
      height: _tableCellHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontFamily: _fontFamily,
        ),
        decoration: const InputDecoration(
          hintText: '…',
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 10,
            fontFamily: _fontFamily,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        ),
      ),
    );
  }

  Widget _buildEditableCellWithDelete(
    TextEditingController controller, {
    required int id,
  }) {
    return Container(
      height: _tableCellHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: _fontFamily,
              ),
              decoration: const InputDecoration(
                hintText: '…',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 10,
                  fontFamily: _fontFamily,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.red),
            tooltip: 'Hapus baris',
            onPressed: () => _hapusAnggotaKeluarga(id),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Catatan Warga',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDottedInput(
              'Catatan Keluarga dari',
              _desaWismaController,
              placeholder: 'Masukan Desa Wisma',
            ),
            const SizedBox(height: _gapSmall),
            _buildDottedInput(
              'Anggota Keluarga',
              _anggotaKeluargaController,
              placeholder: 'Masukan Kepala Keluarga',
            ),
            const SizedBox(height: _gapSmall),
            _buildDottedInput(
              'Tahun',
              _tahunController,
              placeholder: 'Masukan Tahun',
            ),
            const SizedBox(height: _gapMedium),
            _buildCheckboxGroup(
              'Kriteria Rumah',
              const ['Sehat', 'Tidak'],
              _kriteriaRumah,
              (value) => setState(() => _kriteriaRumah = value),
            ),
            const SizedBox(height: _gapSmall),
            _buildCheckboxGroup(
              'Jamban Keluarga',
              const ['Ya', 'Tidak'],
              _jambanKeluarga,
              (value) => setState(() => _jambanKeluarga = value),
            ),
            if (_jambanKeluarga == 'Ya') ...[
              const SizedBox(height: 6),
              _buildTwoColRow(
                label: '',
                showColon: false,
                right: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Jumlah : ',
                      style: TextStyle(
                        fontSize: _valueFontSize,
                        fontFamily: _fontFamily,
                      ),
                    ),
                    _inlineNumber(_jumlahJambanOrangController),
                    const SizedBox(width: 4),
                    const Text(
                      'Orang',
                      style: TextStyle(
                        fontSize: _valueFontSize,
                        fontFamily: _fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: _gapSmall),
            _buildCheckboxGroup(
              'Kesehatan',
              ['Sehat', 'Sakit'],
              _kesehatan,
              (value) => setState(() => _kesehatan = value),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 24),
            const Text(
              'Kegiatan Pokok yang dilakukan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: _fontFamily,
              ),
            ),
            const SizedBox(height: _gapMedium),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _tambahAnggotaKeluarga,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Tambah Anggota'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontFamily: _fontFamily,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Total: ${_anggotaKeluarga.length} anggota',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: _fontFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _gapMedium),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 1800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTableHeader(),
                      if (_anggotaKeluarga.isEmpty)
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'Belum ada data anggota keluarga',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontFamily: _fontFamily,
                              ),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: _anggotaKeluarga.map((anggota) {
                            return _buildTableRow(
                              anggota,
                              _anggotaKeluarga.indexOf(anggota),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Keterangan :',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: _fontFamily,
              ),
            ),
            const SizedBox(height: _gapSmall),
            _buildKeteranganItem('Kolom 1', 'Nomor urut anggota'),
            _buildKeteranganItem(
              'Kolom 2',
              'Nama anggota keluarga yang ada di dalam rumah tangga',
            ),
            _buildKeteranganItem(
              'Kolom 3',
              'Status Perkawinan (Menikah, Lajang, Cerai hidup, Cerai mati)',
            ),
            _buildKeteranganItem('Kolom 4', 'Jenis Kelamin (L/P)'),
            _buildKeteranganItem('Kolom 5', 'Tempat Lahir'),
            _buildKeteranganItem(
              'Kolom 6',
              'Tanggal/Bulan/Tahun Lahir atau Umur',
            ),
            _buildKeteranganItem(
              'Kolom 7',
              'Agama (Islam, Kristen, Katolik, Hindu, Buddha, dll)',
            ),
            _buildKeteranganItem(
              'Kolom 8',
              'Pendidikan terakhir (SD, SMP, SMA, PT, dll)',
            ),
            _buildKeteranganItem('Kolom 9', 'Pekerjaan utama anggota keluarga'),
            _buildKeteranganItem(
              'Kolom 10',
              'Berkebutuhan Khusus (cacat mental/fisik, dll)',
            ),
            _buildKeteranganItem(
              'Kolom 11',
              'Penghayatan dengan Pengamalan Pancasila (PKBN, Pola Asuh, Pencegahan KDRT, Trafficking, dsb)',
            ),
            _buildKeteranganItem(
              'Kolom 12',
              'Gotong Royong (kerja bakti, jimpitan, arisan, rukun kematian, bakti sosial, dll)',
            ),
            _buildKeteranganItem(
              'Kolom 13',
              'Pendidikan dan Keterampilan (BKB, PAUD/Sejenis, Paket ABC, KF, dsb)',
            ),
            _buildKeteranganItem(
              'Kolom 14',
              'Pengembangan Kehidupan Berkoperasi (UP2K, Koperasi, dsb)',
            ),
            _buildKeteranganItem(
              'Kolom 15',
              'Perencanaan Sehat (PHBS, Posyandu balita/lansia, kegiatan kesehatan lainnya)',
            ),
            _buildKeteranganItem(
              'Kolom 16',
              'Pangan (jenis makanan pokok, pemanfaatan halaman pekarangan)',
            ),
            _buildKeteranganItem(
              'Kolom 17',
              'Sandang (usaha/kegiatan yang berkaitan dengan sandang)',
            ),
            _buildKeteranganItem(
              'Kolom 18',
              'Kesehatan (kegiatan kesehatan yang diikuti)',
            ),
            _buildKeteranganItem(
              'Kolom 19',
              'Ket (hal-hal yang belum tercantum di kolom sebelumnya)',
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.initial != null)
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (widget.initial?.id != null) {
                        await _controller.deleteCatatan(widget.initial!.id!);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data berhasil dihapus'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text(
                      'Hapus Data',
                      style: TextStyle(fontSize: 14, fontFamily: _fontFamily),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final nama = _anggotaKeluargaController.text.trim();
                    final mawar = _desaWismaController.text.trim();
                    final tahun = _tahunController.text.trim();

                    if (nama.isNotEmpty &&
                        mawar.isNotEmpty &&
                        tahun.isNotEmpty) {
                      final catatan = Catatan(
                        id: widget.initial?.id,
                        nama: nama,
                        mawar: mawar,
                        tahun: tahun,
                        kriteriaRumah: _kriteriaRumah,
                        jambanKeluarga: _jambanKeluarga,
                        jumlahJambanOrang: _jumlahJambanOrangController.text,
                        kesehatan: _kesehatan,
                        anggotaKeluarga: _anggotaKeluarga.isNotEmpty
                            ? jsonEncode(
                                _anggotaKeluarga.map((e) => e.toMap()).toList(),
                              )
                            : null,
                      );

                      if (widget.initial != null) {
                        await _controller.updateCatatan(catatan);
                      } else {
                        await _controller.addCatatan(catatan);
                      }

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data berhasil disimpan'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C4A7C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.save_alt, size: 18),
                  label: const Text(
                    'Simpan Data',
                    style: TextStyle(fontSize: 14, fontFamily: _fontFamily),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeteranganItem(String label, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label :',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: _fontFamily,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                fontFamily: _fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
