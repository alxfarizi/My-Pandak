//tambah_data_data_keluarga_page.dart - COMPREHENSIVE FIX
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/keluarga_controller.dart';
import '../controllers/anggota_keluarga_controller.dart';
import '../data/models/keluarga.dart';
import '../data/models/anggota_keluarga.dart';

class TambahDataKeluargaPage extends StatefulWidget {
  final Keluarga? initial;

  const TambahDataKeluargaPage({super.key, this.initial});

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

  // Form Controllers
  final TextEditingController _desaWismaController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _dusunController = TextEditingController();
  final TextEditingController _lingkunganController = TextEditingController();
  final TextEditingController _namaKepalaRumahTanggaController =
      TextEditingController();
  final TextEditingController _namaKrtPerkaranganController =
      TextEditingController();
  final TextEditingController _namaKrtIndustriController =
      TextEditingController();
  final TextEditingController _jumlahAnggotaController =
      TextEditingController();
  final TextEditingController _jumlahLakiController = TextEditingController();
  final TextEditingController _jumlahPerempuanController =
      TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _jumlahKkController = TextEditingController();
  final TextEditingController _balitaController = TextEditingController();
  final TextEditingController _pusController = TextEditingController();
  final TextEditingController _wusController = TextEditingController();
  final TextEditingController _butaController = TextEditingController();
  final TextEditingController _ibuHamilController = TextEditingController();
  final TextEditingController _ibuMenyusuiController = TextEditingController();
  final TextEditingController _lansiaController = TextEditingController();
  final TextEditingController _jumlahJambanOrangController =
      TextEditingController();
  final TextEditingController _jenisUsahaController = TextEditingController();

  // Form State Variables
  String? _lansiaKriteria;
  String? _makananPokok;
  String? _jambanKeluarga;
  String? _sumberAir;
  String? _tempatSampah;
  String? _saluranAirLimbah;
  String? _menempelStikerP4k;
  String? _kriteriaRumah;
  String? _aktivitasUp2k;
  String? _jenisUsahaPilihan;
  String? _aktivitasKegiatanKesehatan;
  String? _berkebutuhanKhusus;

  // Anggota Keluarga Data
  List<_AnggotaRowData> _anggotaKeluarga = [];
  int _nextAnggotaId =
      10001; // FIXED: Start from high number to avoid conflicts

  // Table Keys
  final GlobalKey<_EditableTableState> _pemanfaatanTanahKey = GlobalKey();
  final GlobalKey<_EditableTableState> _industriKeluargaKey = GlobalKey();

  // Initial Data
  List<Map<String, dynamic>>? _initialPemanfaatanTanah;
  List<Map<String, dynamic>>? _initialIndustriKeluarga;

  // Controllers
  late KeluargaController _keluargaController;
  late AnggotaKeluargaController _anggotaController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _keluargaController = context.read<KeluargaController>();
      _anggotaController = context.read<AnggotaKeluargaController>();
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    if (_isInitialized) return;
    _isInitialized = true;

    if (widget.initial != null) {
      await _initializeEditMode();
    }
  }

  Future<void> _initializeEditMode() async {
    final data = widget.initial!;

    await _keluargaController.getKeluargaByIdWithAnggota(data.id!);

    // Populate form fields
    _desaWismaController.text = 'Desa Wisma ${data.desaWismaId ?? ''}';
    _rtController.text = data.rt ?? '';
    _rwController.text = data.rw ?? '';
    _dusunController.text = data.dusun ?? '';
    _lingkunganController.text = data.lingkungan ?? '';
    _namaKepalaRumahTanggaController.text = data.namaKepalaKeluarga;
    _jumlahAnggotaController.text = data.jumlahAnggota.toString();
    _jumlahLakiController.text = data.jumlahLaki?.toString() ?? '';
    _jumlahPerempuanController.text = data.jumlahPerempuan?.toString() ?? '';
    _jumlahKkController.text = data.jumlahKk?.toString() ?? '';
    _balitaController.text = data.jumlahBalita?.toString() ?? '';
    _pusController.text = data.jumlahPus?.toString() ?? '';
    _wusController.text = data.jumlahWus?.toString() ?? '';
    _butaController.text = data.jumlahButa?.toString() ?? '';
    _ibuHamilController.text = data.jumlahIbuHamil?.toString() ?? '';
    _ibuMenyusuiController.text = data.jumlahIbuMenyusui?.toString() ?? '';
    _lansiaController.text = data.jumlahLansia?.toString() ?? '';
    _lansiaKriteria = data.kriteriaLansia;
    _makananPokok = data.makananPokok;
    _jambanKeluarga = data.jambanKeluarga == true ? 'Ya' : 'Tidak';
    _jumlahJambanOrangController.text =
        data.jumlahJambanOrang?.toString() ?? '';
    _sumberAir = data.sumberAir;
    _tempatSampah = data.tempatSampah == true ? 'Ya' : 'Tidak';
    _saluranAirLimbah = data.saluranAirLimbah == true ? 'Ya' : 'Tidak';
    _menempelStikerP4k = data.stikerP4k == true ? 'Ya' : 'Tidak';
    _kriteriaRumah = data.kriteriaRumah;
    _aktivitasUp2k = data.aktivitasUp2k == true ? 'Ya' : 'Tidak';
    _jenisUsahaPilihan = data.jenisUsahaUp2k;
    _aktivitasKegiatanKesehatan = data.aktivitasKesehatanLingkungan;
    _namaKrtPerkaranganController.text = data.namaKepalaKeluarga;
    _namaKrtIndustriController.text = data.namaKepalaKeluarga;

    _loadAnggotaFromController();
    setState(() {});
  }

  void _loadAnggotaFromController() {
    final anggotaList = _keluargaController.selectedKeluargaAnggota;
    _anggotaKeluarga.clear();

    for (int i = 0; i < anggotaList.length; i++) {
      final anggota = anggotaList[i];
      final row = _AnggotaRowData(
        id: anggota.id ?? _nextAnggotaId++,
        no: i + 1,
      );
      row.noReg.text = anggota.noRegistrasi ?? '';
      row.nama.text = anggota.nama;
      row.statusKeluarga.text = anggota.statusDalamKeluarga ?? '';
      row.statusPerkawinan.text = anggota.statusPerkawinan ?? '';
      row.jenisKelamin = anggota.jenisKelamin;

      if (anggota.tanggalLahir != null) {
        row.tglUmur.text =
        '${anggota.tanggalLahir!.day}/${anggota.tanggalLahir!.month}/${anggota.tanggalLahir!.year}';
      } else if (anggota.umur != null) {
        row.tglUmur.text = '${anggota.umur} tahun';
      }

      row.pendidikan.text = anggota.pendidikan ?? '';
      row.pekerjaan.text = anggota.pekerjaan ?? '';
      _anggotaKeluarga.add(row);
    }

    if (_anggotaKeluarga.isNotEmpty) {
      final maxId = _anggotaKeluarga
          .map((e) => e.id)
          .reduce((curr, next) => curr > next ? curr : next);
      _nextAnggotaId = maxId >= 10000 ? maxId + 1 : 10001;
    }
  }




  @override
  void dispose() {
    for (var anggota in _anggotaKeluarga) {
      anggota.dispose();
    }
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

  // FIXED: Comprehensive data validation and saving
  Future<void> _simpanData() async {
    if (_namaKepalaRumahTanggaController.text.trim().isEmpty) {
      _showError('Nama Kepala Rumah Tangga harus diisi');
      return;
    }

    // FIXED: Validate anggota data
    final validAnggota = _anggotaKeluarga
        .where((row) => row.nama.text.trim().isNotEmpty)
        .toList();

    if (validAnggota.isEmpty) {
      _showError('Minimal harus ada satu anggota keluarga');
      return;
    }

    try {
      final pemanfaatanTanah = _pemanfaatanTanahKey.currentState?.getData();
      final industriKeluarga = _industriKeluargaKey.currentState?.getData();

      final keluarga = Keluarga(
        id: widget.initial?.id,
        desaWismaId: 1,
        namaKepalaKeluarga: _namaKepalaRumahTanggaController.text.trim(),
        rt: _rtController.text.trim().isEmpty
            ? null
            : _rtController.text.trim(),
        rw: _rwController.text.trim().isEmpty
            ? null
            : _rwController.text.trim(),
        dusun: _dusunController.text.trim().isEmpty
            ? null
            : _dusunController.text.trim(),
        lingkungan: _lingkunganController.text.trim().isEmpty
            ? null
            : _lingkunganController.text.trim(),
        jumlahAnggota: int.tryParse(_jumlahAnggotaController.text) ?? 0,
        jumlahLaki: int.tryParse(_jumlahLakiController.text) ?? 0,
        jumlahPerempuan: int.tryParse(_jumlahPerempuanController.text) ?? 0,
        jumlahKk: int.tryParse(_jumlahKkController.text) ?? 1,
        jumlahBalita: int.tryParse(_balitaController.text) ?? 0,
        jumlahPus: int.tryParse(_pusController.text) ?? 0,
        jumlahWus: int.tryParse(_wusController.text) ?? 0,
        jumlahButa: int.tryParse(_butaController.text) ?? 0,
        jumlahIbuHamil: int.tryParse(_ibuHamilController.text) ?? 0,
        jumlahIbuMenyusui: int.tryParse(_ibuMenyusuiController.text) ?? 0,
        jumlahLansia: int.tryParse(_lansiaController.text) ?? 0,
        kriteriaLansia: _lansiaKriteria,
        makananPokok: _makananPokok,
        jambanKeluarga: _jambanKeluarga == 'Ya',
        jumlahJambanOrang: int.tryParse(_jumlahJambanOrangController.text) ?? 0,
        sumberAir: _sumberAir,
        tempatSampah: _tempatSampah == 'Ya',
        saluranAirLimbah: _saluranAirLimbah == 'Ya',
        stikerP4k: _menempelStikerP4k == 'Ya',
        kriteriaRumah: _kriteriaRumah,
        aktivitasUp2k: _aktivitasUp2k == 'Ya',
        jenisUsahaUp2k: _jenisUsahaPilihan,
        aktivitasKesehatanLingkungan: _aktivitasKegiatanKesehatan,
      );

      // FIXED: Proper anggota data conversion with validation
      final anggotaList = validAnggota.map((row) {
        // FIXED: Parse date from tglUmur field
        DateTime? tanggalLahir;
        int? umur;

        final tglUmurText = row.tglUmur.text.trim();
        if (tglUmurText.isNotEmpty) {
          if (tglUmurText.contains('/')) {
            // Try to parse as date (dd/mm/yyyy)
            try {
              final parts = tglUmurText.split('/');
              if (parts.length == 3) {
                final day = int.parse(parts[0]);
                final month = int.parse(parts[1]);
                final year = int.parse(parts[2]);
                tanggalLahir = DateTime(year, month, day);
              }
            } catch (e) {
              // Ignore parsing error
            }
          } else if (tglUmurText.contains('tahun')) {
            // Try to parse as age
            try {
              umur = int.parse(tglUmurText.replaceAll('tahun', '').trim());
            } catch (e) {
              // Try to parse as plain number
              umur = int.tryParse(tglUmurText);
            }
          } else {
            // Try to parse as plain number (age)
            umur = int.tryParse(tglUmurText);
          }
        }

        return AnggotaKeluarga(
          id: row.id >= 10000 ? null : row.id,
          // FIXED: Only set ID for existing records
          keluargaId: 0,
          // Will be set by controller after keluarga is saved
          noRegistrasi: row.noReg.text.trim().isEmpty
              ? null
              : row.noReg.text.trim(),
          nama: row.nama.text.trim(),
          statusDalamKeluarga: row.statusKeluarga.text.trim().isEmpty
              ? null
              : row.statusKeluarga.text.trim(),
          statusPerkawinan: row.statusPerkawinan.text.trim().isEmpty
              ? null
              : row.statusPerkawinan.text.trim(),
          jenisKelamin: row.jenisKelamin,
          // FIXED: Keep as 'L' or 'P'
          tanggalLahir: tanggalLahir,
          umur: umur,
          pendidikan: row.pendidikan.text.trim().isEmpty
              ? null
              : row.pendidikan.text.trim(),
          pekerjaan: row.pekerjaan.text.trim().isEmpty
              ? null
              : row.pekerjaan.text.trim(),
        );
      }).toList();

      bool success;
      if (widget.initial != null) {
        success = await _keluargaController.updateKeluargaWithAnggota(
          widget.initial!.id!,
          keluarga,
          anggotaList,
        );
        if (success) {
          _showSuccess('Data keluarga berhasil diperbarui!');
        }
      } else {
        final savedKeluarga = await _keluargaController
            .createKeluargaWithAnggota(keluarga, anggotaList);
        success = savedKeluarga != null;
        if (success) {
          _showSuccess('Data keluarga berhasil disimpan!');
        }
      }

      if (success) {
        Navigator.pop(context, true);
      } else {
        _showError(_keluargaController.error ?? 'Gagal menyimpan data');
      }
    } catch (e) {
      _showError('Gagal menyimpan data: $e');
    }
  }

  Future<void> _hapusData() async {
    if (widget.initial?.id == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus data keluarga ini? Semua anggota keluarga juga akan terhapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final success = await _keluargaController.deleteKeluarga(
          widget.initial!.id!,
        );
        if (success) {
          _showSuccess('Data keluarga berhasil dihapus!');
          Navigator.pop(context, true);
        } else {
          _showError(_keluargaController.error ?? 'Gagal menghapus data');
        }
      } catch (e) {
        _showError('Gagal menghapus data: $e');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // UI Builder Methods (unchanged)
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
    );
  }

  Widget _buildCountWithUnit(
    String label,
    TextEditingController controller,
    String unit,
  ) {
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '...',
                    hintStyle: const TextStyle(
                      color: _dotColor,
                      fontSize: _valueFontSize,
                      fontFamily: _fontFamily,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: _valueFontSize,
                    fontFamily: _fontFamily,
                  ),
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            unit,
            style: const TextStyle(
              fontSize: _valueFontSize,
              fontFamily: _fontFamily,
            ),
          ),
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
            keyboardType: TextInputType.number,
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

  Widget _inlineLabeledCount(
    String label,
    TextEditingController controller,
    String unit,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (context) {
            final lower = label.toLowerCase();
            final isShort =
                label.length <= 10 ||
                lower.contains('wus') ||
                lower.contains('buta') ||
                lower.contains('plus');
            final double labelFont = isShort ? 11 : 10;
            return Text(
              label,
              style: TextStyle(fontSize: labelFont, fontFamily: _fontFamily),
            );
          },
        ),
        const SizedBox(width: 3),
        const Text(
          ':',
          style: TextStyle(fontSize: _valueFontSize, fontFamily: _fontFamily),
        ),
        const SizedBox(width: 3),
        SizedBox(
          width: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '....',
                  hintStyle: TextStyle(
                    color: _dotColor,
                    fontSize: _valueFontSize,
                    fontFamily: _fontFamily,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(
                  fontSize: _valueFontSize,
                  fontFamily: _fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
              _dottedUnderline(),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          unit,
          style: const TextStyle(
            fontSize: _valueFontSize,
            fontFamily: _fontFamily,
          ),
        ),
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '....',
                  hintStyle: TextStyle(
                    color: _dotColor,
                    fontSize: _valueFontSize,
                    fontFamily: _fontFamily,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(
                  fontSize: _valueFontSize,
                  fontFamily: _fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
              _dottedUnderline(),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          unit,
          style: const TextStyle(
            fontSize: _valueFontSize,
            fontFamily: _fontFamily,
          ),
        ),
      ],
    );
  }

  // FIXED: Update tambah anggota method - no auto NIK fill
  void _tambahAnggotaKeluarga() {
    setState(() {
      _anggotaKeluarga.add(
        _AnggotaRowData(id: _nextAnggotaId++, no: _anggotaKeluarga.length + 1),
      );
      // FIXED: Don't auto-fill NIK for additional members
    });
  }

  void _hapusAnggotaKeluarga(int id) {
    setState(() {
      final index = _anggotaKeluarga.indexWhere((element) => element.id == id);
      if (index != -1) {
        _anggotaKeluarga[index].dispose();
        _anggotaKeluarga.removeAt(index);
        for (int i = 0; i < _anggotaKeluarga.length; i++) {
          _anggotaKeluarga[i].no = i + 1;
        }
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
        title: Text(
          widget.initial != null ? 'Edit Data Keluarga' : 'Data Keluarga',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<KeluargaController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Alamat Section
                Padding(
                  padding: _sectionPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDottedInput(
                        'Desa Wisma',
                        _desaWismaController,
                        placeholder: 'Masukan Desa Wisma',
                      ),
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
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'RT',
                                      hintStyle: const TextStyle(
                                        color: _dotColor,
                                        fontSize: _valueFontSize,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      fontSize: _valueFontSize,
                                    ),
                                  ),
                                  _dottedUnderline(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '/',
                              style: TextStyle(fontSize: _valueFontSize),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _rwController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'RW',
                                      hintStyle: const TextStyle(
                                        color: _dotColor,
                                        fontSize: _valueFontSize,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      fontSize: _valueFontSize,
                                    ),
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
                                      hintStyle: const TextStyle(
                                        color: _dotColor,
                                        fontSize: _valueFontSize,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      fontSize: _valueFontSize,
                                    ),
                                  ),
                                  _dottedUnderline(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '/',
                              style: TextStyle(fontSize: _valueFontSize),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _lingkunganController,
                                    decoration: InputDecoration(
                                      hintText: 'Lingkungan',
                                      hintStyle: const TextStyle(
                                        color: _dotColor,
                                        fontSize: _valueFontSize,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      fontSize: _valueFontSize,
                                    ),
                                  ),
                                  _dottedUnderline(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Desa pandak Kec Baturaden',
                        style: TextStyle(fontSize: _valueFontSize),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Kab. Banyumas Prov. Jawa Tengah',
                        style: TextStyle(fontSize: _valueFontSize),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Nama Kepala Rumah Tangga
                _buildDottedInput(
                  'Nama Kepala Rumah Tangga',
                  _namaKepalaRumahTanggaController,
                  placeholder: 'Masukan Nama Kepala Rumah Tangga',
                ),
                const SizedBox(height: 20),

                // Jumlah Anggota Keluarga
                _buildTwoColRow(
                  label: 'Jumlah Anggota Keluarga',
                  right: Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _inlineCount(_jumlahAnggotaController, 'Orang'),
                      _inlineLabeledCount(
                        'Laki-laki',
                        _jumlahLakiController,
                        'Orang',
                      ),
                      _inlineLabeledCount(
                        'Perempuan',
                        _jumlahPerempuanController,
                        'Orang',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Detail Jumlah
                _indented(
                  _buildCountWithUnit(
                    '1. Jumlah KK',
                    _jumlahKkController,
                    'KK',
                  ),
                ),
                const SizedBox(height: 8),
                _indented(
                  _buildTwoColRow(
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
                                _inlineLabeledCount(
                                  'A). Balita',
                                  _balitaController,
                                  'Anak',
                                ),
                                const SizedBox(height: 8),
                                _inlineLabeledCount(
                                  'C). WUS',
                                  _wusController,
                                  'Orang',
                                ),
                                const SizedBox(height: 8),
                                _inlineLabeledCount(
                                  'E). Ibu Hamil',
                                  _ibuHamilController,
                                  'Orang',
                                ),
                                const SizedBox(height: 8),
                                _inlineLabeledCount(
                                  'G). Lansia',
                                  _lansiaController,
                                  'Orang',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _inlineLabeledCount(
                                  'B). Plus',
                                  _pusController,
                                  'Pasang',
                                ),
                                const SizedBox(height: 8),
                                _inlineLabeledCount(
                                  'D). Buta',
                                  _butaController,
                                  'Orang',
                                ),
                                const SizedBox(height: 8),
                                _inlineLabeledCount(
                                  'F). Ibu Menyusui',
                                  _ibuMenyusuiController,
                                  'Orang',
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'H). Berkebutuhan Khusus',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: _fontFamily,
                                  ),
                                ),
                                _checkboxOptionsInline(
                                  ['Fisik', 'Non Fisik'],
                                  _berkebutuhanKhusus,
                                  (value) => setState(
                                    () => _berkebutuhanKhusus = value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Anggota Keluarga Table
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Total: ${_anggotaKeluarga.length} anggota',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
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
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'NO',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'NO. REG',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Nama Anggota',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Status Dlm Keluarga',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Status Dlm Perkawinan',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Jenis Kelamin',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Tgl. Lahir / Umur',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Pendidikan',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Pekerjaan',
                                    style: TextStyle(
                                      fontSize: _labelFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_anggotaKeluarga.isEmpty)
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.black, width: 1),
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
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
                          ..._anggotaKeluarga
                              .map(
                                (anggota) => Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            anggota.no.toString(),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.noReg,
                                            decoration: const InputDecoration(
                                              hintText: 'Nomor Registrasi',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.nama,
                                            decoration: const InputDecoration(
                                              hintText: 'Nama Anggota',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.statusKeluarga,
                                            decoration: const InputDecoration(
                                              hintText: 'Status Dlm Keluarga',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller:
                                                anggota.statusPerkawinan,
                                            decoration: const InputDecoration(
                                              hintText: 'Status Dlm Perkawinan',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // FIXED: Proper jenis kelamin checkbox with 'L'/'P' values
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 6,
                                          ),
                                          child: Wrap(
                                            spacing: 4,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () => setState(
                                                  () => anggota.jenisKelamin =
                                                      anggota.jenisKelamin ==
                                                          'L'
                                                      ? null
                                                      : 'L',
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              2,
                                                            ),
                                                        color: Colors.white,
                                                      ),
                                                      child:
                                                          anggota.jenisKelamin ==
                                                              'L'
                                                          ? Center(
                                                              child: Container(
                                                                width: 6,
                                                                height: 6,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        2,
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Text(
                                                      'L',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => setState(
                                                  () => anggota.jenisKelamin =
                                                      anggota.jenisKelamin ==
                                                          'P'
                                                      ? null
                                                      : 'P',
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              2,
                                                            ),
                                                        color: Colors.white,
                                                      ),
                                                      child:
                                                          anggota.jenisKelamin ==
                                                              'P'
                                                          ? Center(
                                                              child: Container(
                                                                width: 6,
                                                                height: 6,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        2,
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Text(
                                                      'P',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.tglUmur,
                                            decoration: const InputDecoration(
                                              hintText: 'Tgl. Lahir / Umur',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.pendidikan,
                                            decoration: const InputDecoration(
                                              hintText: 'Pendidikan',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: TextField(
                                            controller: anggota.pekerjaan,
                                            decoration: const InputDecoration(
                                              hintText: 'Pekerjaan',
                                              hintStyle: TextStyle(
                                                color: _dotColor,
                                                fontSize: _valueFontSize,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            style: const TextStyle(
                                              fontSize: _valueFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 4,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          onPressed: () =>
                                              _hapusAnggotaKeluarga(anggota.id),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
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

                // Checklist Questions (unchanged - keeping all existing form elements)
                _indented(
                  _buildCheckboxGroup(
                    '3. Makanan Pokok Sehari-hari',
                    ['Beras', 'Non Beras'],
                    _makananPokok,
                    (v) => setState(() => _makananPokok = v),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildTwoColRow(
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
                              onTap: () => setState(
                                () => _jambanKeluarga = _jambanKeluarga == 'Ya'
                                    ? null
                                    : 'Ya',
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: _jambanKeluarga == 'Ya'
                                        ? Center(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Ya',
                                    style: TextStyle(fontSize: _valueFontSize),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(
                                () => _jambanKeluarga =
                                    _jambanKeluarga == 'Tidak' ? null : 'Tidak',
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: _jambanKeluarga == 'Tidak'
                                        ? Center(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Tidak',
                                    style: TextStyle(fontSize: _valueFontSize),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (_jambanKeluarga == 'Ya') ...[
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Jumlah : ',
                                style: TextStyle(fontSize: _valueFontSize),
                              ),
                              _inlineNumber(_jumlahJambanOrangController),
                              const SizedBox(width: 4),
                              const Text(
                                'Orang',
                                style: TextStyle(fontSize: _valueFontSize),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '5. Sumber Air Keluarga',
                    ['PDAM', 'Sumur', 'Lainnya'],
                    _sumberAir,
                    (v) => setState(() => _sumberAir = v),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '6. Memiliki Tempat Pembuangan Sampah',
                    ['Ya', 'Tidak'],
                    _tempatSampah,
                    (v) => setState(() => _tempatSampah = v),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '7. Mempunyai Saluran Pembuangan Air Limbah',
                    ['Ya', 'Tidak'],
                    _saluranAirLimbah,
                    (v) => setState(() => _saluranAirLimbah = v),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '8. Menempel Stiker P4K',
                    ['Ya', 'Tidak'],
                    _menempelStikerP4k,
                    (v) => setState(() => _menempelStikerP4k = v),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '9. Kriteria Rumah',
                    ['Sehat', 'Kurang Sehat'],
                    _kriteriaRumah,
                    (v) => setState(() => _kriteriaRumah = v),
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildTwoColRow(
                    label: '10. Aktivitas UP2K',
                    rowAlign: CrossAxisAlignment.start,
                    right: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 32,
                          children: [
                            InkWell(
                              onTap: () => setState(
                                () => _aktivitasUp2k = _aktivitasUp2k == 'Ya'
                                    ? null
                                    : 'Ya',
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: _aktivitasUp2k == 'Ya'
                                        ? Center(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Ya',
                                    style: TextStyle(fontSize: _valueFontSize),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(
                                () => _aktivitasUp2k = _aktivitasUp2k == 'Tidak'
                                    ? null
                                    : 'Tidak',
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    child: _aktivitasUp2k == 'Tidak'
                                        ? Center(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Tidak',
                                    style: TextStyle(fontSize: _valueFontSize),
                                  ),
                                ],
                              ),
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
                                style: TextStyle(
                                  fontSize: _valueFontSize,
                                  fontFamily: _fontFamily,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => setState(
                                      () => _jenisUsahaPilihan =
                                          _jenisUsahaPilihan == 'Warung'
                                          ? null
                                          : 'Warung',
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 2,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                            ),
                                            child:
                                                _jenisUsahaPilihan == 'Warung'
                                                ? Center(
                                                    child: Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              2,
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'Warung',
                                            style: TextStyle(
                                              fontSize: _valueFontSize,
                                              fontFamily: _fontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  InkWell(
                                    onTap: () => setState(
                                      () => _jenisUsahaPilihan =
                                          _jenisUsahaPilihan ==
                                              'Kegiatan Koperasi'
                                          ? null
                                          : 'Kegiatan Koperasi',
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 2,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                            ),
                                            child:
                                                _jenisUsahaPilihan ==
                                                    'Kegiatan Koperasi'
                                                ? Center(
                                                    child: Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              2,
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'Kegiatan Koperasi',
                                            style: TextStyle(
                                              fontSize: _valueFontSize,
                                              fontFamily: _fontFamily,
                                            ),
                                          ),
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
                  ),
                ),
                const SizedBox(height: 12),
                _indented(
                  _buildCheckboxGroup(
                    '11. Aktivitas Kegiatan Usaha Kesehatan Lingkungan',
                    ['Layak', 'Tidak Layak'], // This is already correct
                    _aktivitasKegiatanKesehatan,
                    (v) => setState(() => _aktivitasKegiatanKesehatan = v),
                  ),
                ),
                const SizedBox(height: 20),

                // Pemanfaatan Tanah Section
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
                      key: _pemanfaatanTanahKey,
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
                      initialData: _initialPemanfaatanTanah,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Industri Keluarga Section
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
                      key: _industriKeluargaKey,
                      headers: const ['No', 'Keterangan', 'Komoditi', 'Volume'],
                      initialRows: 4,
                      presetKeterangan: const [
                        'Pangan',
                        'Sandang',
                        'Jasa',
                        'Lain-lain',
                      ],
                      cellHeight: _tableCellHeight,
                      initialData: _initialIndustriKeluarga,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.initial != null)
                      ElevatedButton.icon(
                        onPressed: _hapusData,
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
                        icon: const Icon(Icons.delete_outline, size: 20),
                        label: const Text('Hapus Data'),
                      ),
                    ElevatedButton.icon(
                      onPressed: _simpanData,
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
                      icon: const Icon(Icons.save_outlined, size: 20),
                      label: const Text('Simpan Data'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Helper Classes
class _AnggotaRowData {
  final int id;
  int no;
  final TextEditingController noReg = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController statusKeluarga = TextEditingController();
  final TextEditingController statusPerkawinan = TextEditingController();
  String? jenisKelamin; // FIXED: Keep as 'L'/'P' for database compatibility
  final TextEditingController tglUmur = TextEditingController();
  final TextEditingController pendidikan = TextEditingController();
  final TextEditingController pekerjaan = TextEditingController();

  _AnggotaRowData({required this.id, required this.no});

  void dispose() {
    noReg.dispose();
    nama.dispose();
    statusKeluarga.dispose();
    statusPerkawinan.dispose();
    tglUmur.dispose();
    pendidikan.dispose();
    pekerjaan.dispose();
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: _TambahDataKeluargaPageState._labelFontSize,
        fontWeight: FontWeight.w700,
      ),
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
            style: const TextStyle(
              fontSize: _TambahDataKeluargaPageState._labelFontSize,
            ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                ),
                style: const TextStyle(
                  fontSize: _TambahDataKeluargaPageState._valueFontSize,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  const double dotWidth = 3;
                  const double spacing = 4;
                  final int count =
                      (constraints.maxWidth / (dotWidth + spacing)).floor();
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
              ),
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
  final List<Map<String, dynamic>>? initialData;

  const _EditableTable({
    Key? key,
    required this.headers,
    this.initialRows = 1,
    this.cellHeight = 28,
    this.presetKeterangan,
    this.showJumlahRow = true,
    this.initialData,
  }) : super(key: key);

  @override
  State<_EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends State<_EditableTable> {
  final List<_TableRowData> _rows = [];
  double _volumeTotal = 0;
  final TextEditingController _jumlahKomoditiController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeRows();
  }

  void _initializeRows() {
    final int count = widget.presetKeterangan?.length ?? widget.initialRows;
    for (int i = 0; i < count; i++) {
      final row = _TableRowData();
      if (widget.presetKeterangan != null &&
          i < widget.presetKeterangan!.length) {
        row.keterangan.text = widget.presetKeterangan![i];
      }

      // Populate dengan initial data jika ada
      if (widget.initialData != null && i < widget.initialData!.length) {
        final data = widget.initialData![i];
        row.komoditi.text = data['komoditi'] ?? '';
        row.volume.text = data['volume']?.toString() ?? '';
      }

      row.volume.addListener(_recomputeVolume);
      _rows.add(row);
    }

    // Populate jumlah komoditi jika ada initial data
    if (widget.initialData != null && widget.initialData!.isNotEmpty) {
      final firstData = widget.initialData!.first;
      _jumlahKomoditiController.text = firstData['jumlah_komoditi'] ?? '';
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

  // Method untuk mendapatkan data dari tabel
  List<Map<String, dynamic>> getData() {
    return _rows
        .map(
          (row) => {
            'keterangan': row.keterangan.text,
            'komoditi': row.komoditi.text,
            'volume':
                double.tryParse(row.volume.text.replaceAll(',', '.')) ?? 0,
            'jumlah_komoditi': _jumlahKomoditiController.text,
          },
        )
        .toList();
  }

  Widget _cell({
    required Widget child,
    bool isHeader = false,
    bool isReadonly = false,
  }) {
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
            Expanded(
              child: _cell(child: Text(widget.headers[0]), isHeader: true),
            ),
            Expanded(
              flex: 3,
              child: _cell(child: Text(widget.headers[1]), isHeader: true),
            ),
            Expanded(
              flex: 3,
              child: _cell(child: Text(widget.headers[2]), isHeader: true),
            ),
            Expanded(
              flex: 2,
              child: _cell(child: Text(widget.headers[3]), isHeader: true),
            ),
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
                          style: const TextStyle(
                            fontSize:
                                _TambahDataKeluargaPageState._valueFontSize,
                          ),
                        )
                      : TextField(
                          controller: r.keterangan,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(
                            fontSize:
                                _TambahDataKeluargaPageState._valueFontSize,
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 3,
                child: _cell(
                  child: TextField(
                    controller: r.komoditi,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: _TambahDataKeluargaPageState._valueFontSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: _cell(
                  child: TextField(
                    controller: r.volume,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: _TambahDataKeluargaPageState._valueFontSize,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          );
        }),
        if (widget.showJumlahRow)
          Row(
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: _TambahDataKeluargaPageState._valueFontSize,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 2, child: _cell(child: Text('$_volumeTotal'))),
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
