//tambah_data_catatan_keluarga_page.dart - FIXED TEXT INPUT VERSION
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/catatan_keluarga_controller.dart';
import '../controllers/keluarga_controller.dart';
import '../data/models/catatan_keluarga.dart';
import '../data/models/keluarga.dart';
import '../controllers/auth_controller.dart';

class TambahDataCatatanKeluargaPage extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  const TambahDataCatatanKeluargaPage({super.key, this.initialData});

  @override
  State<TambahDataCatatanKeluargaPage> createState() =>
      _TambahDataCatatanKeluargaPageState();
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
  String? _tempatSampah;

  late CatatanKeluargaController _catatanController;
  late KeluargaController _keluargaController;

  Keluarga? _selectedKeluarga;
  List<Map<String, dynamic>> _anggotaKeluarga = [];
  bool _isWarga = false;

  // FIXED: Map untuk menyimpan TextEditingController untuk setiap cell
  final Map<String, TextEditingController> _cellControllers = {};

  int _nextAnggotaId = 1001;
  List<int> get _colFlex => _colWidths.map((w) => w.round()).toList();

  int? _editingId;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _catatanController = context.read<CatatanKeluargaController>();
      _keluargaController = context.read<KeluargaController>();
      _checkUserRole();
      _initializePage();
    });
  }void _checkUserRole() {
    final authController = context.read<AuthController>();
    setState(() {
      _isWarga = authController.isWarga;
    });
  }
  void _autoSelectKeluargaForWarga() {
    final keluargaList = _keluargaController.keluargaList;
    if (keluargaList.isNotEmpty) {
      final keluarga = keluargaList.first;
      // FIXED: Call _onKeluargaSelected to properly initialize data
      _onKeluargaSelected(keluarga);
    }
  }

  Future<void> _initializePage() async {
    if (_isInitialized) return;
    _isInitialized = true;

    await _keluargaController.loadKeluarga();

    if (widget.initialData != null) {
      await _initializeEditMode();
    } else {
      _tahunController.text = DateTime.now().year.toString();

      // FIXED: Auto-select keluarga for warga AFTER loading keluarga
      if (_isWarga) {
        _autoSelectKeluargaForWarga();
      }
    }
  }


  Future<void> _initializeEditMode() async {
    final data = widget.initialData!;
    _editingId = data['id'];

    _tahunController.text =
        data['tahun']?.toString() ?? DateTime.now().year.toString();
    _anggotaKeluargaController.text = data['nama_pencatat'] ?? '';
    _desaWismaController.text = data['anggota_kelompok_dasa_wisma'] ?? '';

    // FIXED: Map database values back to UI values
    final dbKriteriaRumah = data['kriteria_rumah'];
    if (dbKriteriaRumah == 'Kurang Sehat') {
      _kriteriaRumah = 'Tidak'; // Map DB value back to UI value
    } else {
      _kriteriaRumah = dbKriteriaRumah; // 'Sehat' remains 'Sehat'
    }

    _jambanKeluarga = data['jamban_keluarga'] == true ? 'Ya' : 'Tidak';
    _jumlahJambanOrangController.text =
        data['jumlah_jamban_orang']?.toString() ?? '';
    _tempatSampah = data['tempat_sampah'] == true ? 'Ada' : 'Tidak';
    _kesehatan = data['status_kesehatan'];

    if (_editingId != null) {
      await _catatanController.getCatatanByIdWithFullData(_editingId!);

      final keluargaId = _catatanController.selectedCatatanKeluarga?.id;
      if (keluargaId != null) {
        _selectedKeluarga = _keluargaController.keluargaList
            .where((k) => k.id == keluargaId)
            .firstOrNull;
      }

      _anggotaKeluarga = List.from(
        _catatanController.selectedCatatanAnggotaData,
      );

      // FIXED: Initialize controllers untuk data yang sudah ada
      _initializeControllersForExistingData();

      if (_anggotaKeluarga.isNotEmpty) {
        final maxId = _anggotaKeluarga
            .map((a) => a['id'] as int? ?? 0)
            .reduce((a, b) => a > b ? a : b);
        _nextAnggotaId = maxId + 1;
      }

      if (_selectedKeluarga != null) {
        _anggotaKeluargaController.text = _selectedKeluarga!.namaKepalaKeluarga;
        _desaWismaController.text =
            'Desa Wisma ${_selectedKeluarga!.desaWismaId ?? ''}';
      }
    }

    setState(() {});
  }

  // FIXED: Method untuk initialize controllers untuk data yang sudah ada
  void _initializeControllersForExistingData() {
    _cellControllers.clear();
    for (final anggota in _anggotaKeluarga) {
      final id = anggota['id'].toString();
      final fields = [
        'nama',
        'statusPerkawinan',
        'jenisKelamin',
        'tempatLahir',
        'tglBlThn',
        'agama',
        'pendidikan',
        'pekerjaan',
        'berkebutuhanKhusus',
        'penghayatanPancasila',
        'gotongRoyong',
        'pendidikanKeterampilan',
        'pengembanganKoperasi',
        'perencanaanSehat',
        'pangan',
        'sandang',
        'kesehatan',
        'ket',
      ];

      for (final field in fields) {
        final key = '${id}_$field';
        _cellControllers[key] = TextEditingController(
          text: anggota[field] ?? '',
        );
      }
    }
  }

  Future<void> _onKeluargaSelected(Keluarga? keluarga) async {
    if (keluarga == null) return;

    setState(() {
      _selectedKeluarga = keluarga;
      _anggotaKeluargaController.text = keluarga.namaKepalaKeluarga;
      _desaWismaController.text = 'Desa Wisma ${keluarga.desaWismaId ?? ''}';
    });

    if (_editingId == null) {
      await _catatanController.prepareCatatanForKeluarga(keluarga.id!);
      setState(() {
        _anggotaKeluarga = List.from(
          _catatanController.selectedCatatanAnggotaData,
        );
        _renumberAnggota();

        // FIXED: Initialize controllers untuk data baru
        _initializeControllersForExistingData();

        if (_anggotaKeluarga.isNotEmpty) {
          final maxId = _anggotaKeluarga
              .map((a) => a['id'] as int? ?? 0)
              .reduce((a, b) => a > b ? a : b);
          _nextAnggotaId = maxId + 1;
        }
      });
    }
  }

  void _renumberAnggota() {
    for (int i = 0; i < _anggotaKeluarga.length; i++) {
      _anggotaKeluarga[i]['no'] = i + 1;
    }
  }

  Future<void> _simpanData() async {
    if (_selectedKeluarga == null) {
      _showError('Pilih keluarga terlebih dahulu');
      return;
    }

    if (_tahunController.text.trim().isEmpty) {
      _showError('Tahun harus diisi');
      return;
    }

    try {
      // FIXED: Map form values to database values
      String? mappedKriteriaRumah;
      if (_kriteriaRumah == 'Tidak') {
        mappedKriteriaRumah = 'Kurang Sehat'; // Map UI value to DB value
      } else {
        mappedKriteriaRumah = _kriteriaRumah; // 'Sehat' remains 'Sehat'
      }

      final catatan = CatatanKeluarga(
        id: _editingId,
        keluargaId: _selectedKeluarga!.id!,
        tahun: int.parse(_tahunController.text.trim()),
        namaPencatat: _anggotaKeluargaController.text.trim().isEmpty
            ? null
            : _anggotaKeluargaController.text.trim(),
        anggotaKelompokDasaWisma: _desaWismaController.text.trim().isEmpty
            ? null
            : _desaWismaController.text.trim(),
        kriteriaRumah: mappedKriteriaRumah, // FIXED: Use mapped value
        jambanKeluarga: _jambanKeluarga == 'Ya',
        jumlahJambanOrang: int.tryParse(_jumlahJambanOrangController.text) ?? 0,
        tempatSampah: _tempatSampah == 'Ada',
        statusKesehatan: _kesehatan,
        tanggalPencatatan: DateTime.now(),
        status: 'Draft',
      );

      bool success;
      if (_editingId != null) {
        success = await _catatanController.updateCatatanWithAnggotaData(
          _editingId!,
          catatan,
          _anggotaKeluarga,
        );
        if (success) {
          _showSuccess('Catatan keluarga berhasil diperbarui!');
        }
      } else {
        success = await _catatanController.createCatatanWithAnggotaData(
          catatan,
          _anggotaKeluarga,
        );
        if (success) {
          _showSuccess('Catatan keluarga berhasil disimpan!');
        }
      }

      if (success) {
        Navigator.pop(context, true);
      } else {
        _showError(_catatanController.error ?? 'Gagal menyimpan data');
      }
    } catch (e) {
      _showError('Gagal menyimpan data: $e');
    }
  }

  Future<void> _hapusData() async {
    if (_editingId == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
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
        final success = await _catatanController.deleteCatatan(_editingId!);
        if (success) {
          _showSuccess('Catatan berhasil dihapus!');
          Navigator.pop(context, true);
        } else {
          _showError(_catatanController.error ?? 'Gagal menghapus data');
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

  @override
  void dispose() {
    _desaWismaController.dispose();
    _anggotaKeluargaController.dispose();
    _tahunController.dispose();
    _jumlahJambanOrangController.dispose();

    // FIXED: Dispose semua cell controllers
    for (final controller in _cellControllers.values) {
      controller.dispose();
    }
    _cellControllers.clear();

    super.dispose();
  }

  // FIXED: Method tambah anggota dengan controller initialization
  void _tambahAnggotaKeluarga() {
    final newAnggota = {
      'id': _nextAnggotaId,
      'no': _anggotaKeluarga.length + 1,
      'nama': '',
      'statusPerkawinan': '',
      'jenisKelamin': '',
      'tempatLahir': '',
      'tglBlThn': '',
      'agama': '',
      'pendidikan': '',
      'pekerjaan': '',
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

    setState(() {
      _anggotaKeluarga.add(newAnggota);

      // FIXED: Initialize controllers untuk anggota baru
      final id = _nextAnggotaId.toString();
      final fields = [
        'nama',
        'statusPerkawinan',
        'jenisKelamin',
        'tempatLahir',
        'tglBlThn',
        'agama',
        'pendidikan',
        'pekerjaan',
        'berkebutuhanKhusus',
        'penghayatanPancasila',
        'gotongRoyong',
        'pendidikanKeterampilan',
        'pengembanganKoperasi',
        'perencanaanSehat',
        'pangan',
        'sandang',
        'kesehatan',
        'ket',
      ];

      for (final field in fields) {
        final key = '${id}_$field';
        _cellControllers[key] = TextEditingController(text: '');
      }

      _nextAnggotaId++;
    });

    _catatanController.updateSelectedCatatanAnggotaData(_anggotaKeluarga);
  }

  void _hapusAnggotaKeluarga(int id) {
    setState(() {
      // FIXED: Dispose controllers untuk anggota yang dihapus
      final idStr = id.toString();
      final fields = [
        'nama',
        'statusPerkawinan',
        'jenisKelamin',
        'tempatLahir',
        'tglBlThn',
        'agama',
        'pendidikan',
        'pekerjaan',
        'berkebutuhanKhusus',
        'penghayatanPancasila',
        'gotongRoyong',
        'pendidikanKeterampilan',
        'pengembanganKoperasi',
        'perencanaanSehat',
        'pangan',
        'sandang',
        'kesehatan',
        'ket',
      ];

      for (final field in fields) {
        final key = '${idStr}_$field';
        _cellControllers[key]?.dispose();
        _cellControllers.remove(key);
      }

      _anggotaKeluarga.removeWhere((anggota) => anggota['id'] == id);
      _renumberAnggota();
    });

    _catatanController.updateSelectedCatatanAnggotaData(_anggotaKeluarga);
  }

  void _updateAnggotaField(int id, String field, String value) {
    final index = _anggotaKeluarga.indexWhere((a) => a['id'] == id);
    if (index != -1) {
      setState(() {
        _anggotaKeluarga[index][field] = value;
      });
      _catatanController.updateSelectedCatatanAnggotaData(_anggotaKeluarga);
    }
  }

  // FIXED: Method untuk mendapatkan atau membuat controller
  TextEditingController _getOrCreateController(
    int id,
    String field,
    String initialValue,
  ) {
    final key = '${id}_$field';
    if (!_cellControllers.containsKey(key)) {
      _cellControllers[key] = TextEditingController(text: initialValue);
    }
    return _cellControllers[key]!;
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

  Widget _buildKeluargaDropdown() {
    return _buildTwoColRow(
      label: _isWarga ? 'Keluarga' : 'Pilih Keluarga',
      right: Consumer<KeluargaController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          Keluarga? validSelectedKeluarga;
          if (_selectedKeluarga != null) {
            validSelectedKeluarga = controller.keluargaList
                .where((k) => k.id == _selectedKeluarga!.id)
                .firstOrNull;
          }

          // ADDED: Show info container for warga instead of dropdown
          if (_isWarga) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.home, size: 16, color: Colors.blue.shade600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      validSelectedKeluarga != null
                          ? '${validSelectedKeluarga.namaKepalaKeluarga} (RT: ${validSelectedKeluarga.rt ?? '-'} / RW: ${validSelectedKeluarga.rw ?? '-'})'
                          : 'Memuat data keluarga...',
                      style: TextStyle(
                        fontSize: _valueFontSize,
                        fontFamily: _fontFamily,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }

          // EXISTING: Show dropdown for admin/pengurus
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Keluarga>(
                value: validSelectedKeluarga,
                hint: Text(
                  'Pilih keluarga...',
                  style: TextStyle(
                    color: _dotColor,
                    fontSize: _valueFontSize,
                    fontFamily: _fontFamily,
                  ),
                ),
                isExpanded: true,
                items: controller.keluargaList.map((keluarga) {
                  return DropdownMenuItem<Keluarga>(
                    value: keluarga,
                    child: Text(
                      '${keluarga.namaKepalaKeluarga} (RT: ${keluarga.rt ?? '-'} / RW: ${keluarga.rw ?? '-'})',
                      style: const TextStyle(
                        fontSize: _valueFontSize,
                        fontFamily: _fontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: _isWarga ? null : _onKeluargaSelected, // ADDED: Disable for warga
              ),
            ),
          );
        },
      ),
    );
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

  Widget _buildTableRow(Map<String, dynamic> anggota, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: index % 2 == 0 ? Colors.white : const Color(0xFFF5F5F5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: _colFlex[0],
            child: _buildTableCell(anggota['no'].toString()),
          ),
          Expanded(
            flex: _colFlex[1],
            child: _buildEditableCell(anggota, 'nama'),
          ),
          Expanded(
            flex: _colFlex[2],
            child: _buildEditableCell(anggota, 'statusPerkawinan'),
          ),
          Expanded(
            flex: _colFlex[3],
            child: _buildEditableCell(anggota, 'jenisKelamin'),
          ),
          Expanded(
            flex: _colFlex[4],
            child: _buildEditableCell(anggota, 'tempatLahir'),
          ),
          Expanded(
            flex: _colFlex[5],
            child: _buildEditableCell(anggota, 'tglBlThn'),
          ),
          Expanded(
            flex: _colFlex[6],
            child: _buildEditableCell(anggota, 'agama'),
          ),
          Expanded(
            flex: _colFlex[7],
            child: _buildEditableCell(anggota, 'pendidikan'),
          ),
          Expanded(
            flex: _colFlex[8],
            child: _buildEditableCell(anggota, 'pekerjaan'),
          ),
          Expanded(
            flex: _colFlex[9],
            child: _buildEditableCell(anggota, 'berkebutuhanKhusus'),
          ),
          Expanded(
            flex: _colFlex[10],
            child: _buildEditableCell(anggota, 'penghayatanPancasila'),
          ),
          Expanded(
            flex: _colFlex[11],
            child: _buildEditableCell(anggota, 'gotongRoyong'),
          ),
          Expanded(
            flex: _colFlex[12],
            child: _buildEditableCell(anggota, 'pendidikanKeterampilan'),
          ),
          Expanded(
            flex: _colFlex[13],
            child: _buildEditableCell(anggota, 'pengembanganKoperasi'),
          ),
          Expanded(
            flex: _colFlex[14],
            child: _buildEditableCell(anggota, 'perencanaanSehat'),
          ),
          Expanded(
            flex: _colFlex[15],
            child: _buildEditableCell(anggota, 'pangan'),
          ),
          Expanded(
            flex: _colFlex[16],
            child: _buildEditableCell(anggota, 'sandang'),
          ),
          Expanded(
            flex: _colFlex[17],
            child: _buildEditableCell(anggota, 'kesehatan'),
          ),
          Expanded(
            flex: _colFlex[18],
            child: _buildEditableCellWithDelete(
              anggota,
              'ket',
              id: anggota['id'] as int,
            ),
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

  // FIXED: Menggunakan persistent controller untuk setiap cell
  Widget _buildEditableCell(Map<String, dynamic> anggota, String field) {
    final id = anggota['id'] as int;
    final controller = _getOrCreateController(id, field, anggota[field] ?? '');

    return Container(
      height: _tableCellHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          _updateAnggotaField(id, field, value);
        },
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
    Map<String, dynamic> anggota,
    String field, {
    required int id,
  }) {
    final controller = _getOrCreateController(id, field, anggota[field] ?? '');

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
              onChanged: (value) => _updateAnggotaField(id, field, value),
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
        title: Text(
          _editingId != null ? 'Edit Catatan Warga' : 'Catatan Warga',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CatatanKeluargaController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildKeluargaDropdown(),
                const SizedBox(height: _gapMedium),

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
                  const ['Sehat', 'Tidak'], // FIXED: Map 'Tidak' to 'Kurang Sehat' in save method
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
                  'Tempat Sampah',
                  const ['Ada', 'Tidak'],
                  _tempatSampah,
                  (value) => setState(() => _tempatSampah = value),
                ),
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
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
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
                _buildKeteranganItem(
                  'Kolom 9',
                  'Pekerjaan utama anggota keluarga',
                ),
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
                    if (_editingId != null)
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
                        icon: const Icon(Icons.delete_outline, size: 18),
                        label: const Text(
                          'Hapus Data',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: _fontFamily,
                          ),
                        ),
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
          );
        },
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
