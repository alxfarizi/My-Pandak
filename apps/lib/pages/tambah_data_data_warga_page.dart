//tambah_data_data_warga_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/anggota_keluarga_service.dart';
import '../services/keluarga_service.dart';
import '../data/models/anggota_keluarga.dart';
import '../data/models/keluarga.dart';
import '../controllers/auth_controller.dart';
import '../services/nik_validation_service.dart';

class TambahDataWargaPage extends StatefulWidget {
  final AnggotaKeluarga? initial;

  const TambahDataWargaPage({super.key, this.initial});

  @override
  State<TambahDataWargaPage> createState() => _TambahDataWargaPageState();
}

class _DashedPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  _DashedPainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.thickness,
  });

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
  // Form Controllers
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
  final TextEditingController _jenisAkseptorKbController =
      TextEditingController();
  final TextEditingController _frekuensiPosyanduController =
      TextEditingController();

  // Form State Variables
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

  // Data keluarga dan state
  List<Keluarga> _keluargaList = [];
  Keluarga? _selectedKeluarga;
  bool _isLoading = false;
  bool _isLoadingKeluarga = true;
  bool _isWarga = false;

  bool get _isEditMode => widget.initial != null;
  bool _isValidatingNik = false;
  String? _nikValidationError;

  // UI Constants
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
  void initState() {
    super.initState();
    _checkUserRole();
    _loadKeluarga();
    _loadCurrentUserNik();

    if (widget.initial != null) {
      _initializeEditMode();
    }
  }

  void _checkUserRole() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = context.read<AuthController>();
      setState(() {
        _isWarga = authController.isWarga;
      });
    });
  }

  Future<void> _loadKeluarga() async {
    try {
      final keluarga = await KeluargaService.getAllKeluarga();
      setState(() {
        _keluargaList = keluarga;
        _isLoadingKeluarga = false;
      });

      // FIXED: Proper order of auto-selection
      if (_isEditMode && widget.initial!.keluargaId != null) {
        _autoSelectKeluargaForEdit();
      } else if (_isWarga && _keluargaList.isNotEmpty) {
        // FIXED: Add small delay to ensure UI is ready
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _autoSelectKeluargaForWarga();
        });
      }
    } catch (e) {
      setState(() => _isLoadingKeluarga = false);
      _showError('Gagal memuat data keluarga: $e');
    }
  }

  void _autoSelectKeluargaForWarga() {
    if (_keluargaList.isNotEmpty) {
      final keluarga = _keluargaList.first;
      setState(() {
        _selectedKeluarga = keluarga;
        _namaKepalaController.text = keluarga.namaKepalaKeluarga;
        _desaWismaController.text = 'Desa Wisma ${keluarga.desaWismaId ?? ''}';
      });
    }
  }

  void _autoSelectKeluargaForEdit() {
    final keluargaId = widget.initial!.keluargaId!;
    try {
      final keluarga = _keluargaList.firstWhere((k) => k.id == keluargaId);
      setState(() {
        _selectedKeluarga = keluarga;
        _namaKepalaController.text = keluarga.namaKepalaKeluarga;
        _desaWismaController.text = 'Desa Wisma ${keluarga.desaWismaId ?? ''}';
      });
    } catch (e) {
      _showError('Data keluarga tidak ditemukan');
    }
  }

  void _loadCurrentUserNik() async {
    final authController = context.read<AuthController>();
    final profile = authController.userProfile;
    final userNik = profile?['nik'];

    // FIXED: Simplified auto-fill logic
    if (widget.initial == null &&
        userNik != null &&
        _noKtpNikController.text.isEmpty &&
        authController.isWarga) {

      // Check if user's NIK is globally available
      final isAvailable = await NikValidationService.isNikAvailable(userNik);

      // Only auto-fill if NIK is available (not used anywhere else)
      if (isAvailable) {
        _noKtpNikController.text = userNik;
      }
      // If not available, leave empty - user must enter different NIK
    }
  }


  Future<void> _validateNik(String nik) async {
    if (nik.isEmpty) {
      setState(() {
        _nikValidationError = null;
        _isValidatingNik = false;
      });
      return;
    }

    setState(() => _isValidatingNik = true);

    try {
      // FIXED: Pass excludeId when in edit mode
      final validation = await NikValidationService.validateNikGlobally(
        nik,
        excludeTable: widget.initial != null ? 'anggota_keluarga' : null,
        excludeId: widget.initial?.id, // FIXED: Exclude current record ID
        currentUserId: context.read<AuthController>().currentUser?.id,
      );

      setState(() {
        _nikValidationError = validation.isValid ? null : validation.error;
        _isValidatingNik = false;
      });
    } catch (e) {
      setState(() {
        _nikValidationError = 'Error validating NIK: $e';
        _isValidatingNik = false;
      });
    }
  }

  void _initializeEditMode() {
    final data = widget.initial!;

    _noRegistrasiController.text = data.noRegistrasi ?? '';
    _noKtpNikController.text = data.nik ?? '';
    _namaController.text = data.nama;
    _jabatanController.text = data.jabatan ?? '';
    _jenisKelamin = data.jenisKelamin;
    _tempatLahirController.text = data.tempatLahir ?? '';

    if (data.tanggalLahir != null) {
      _tanggalLahirController.text = data.tanggalLahir!.day.toString();
      _bulanLahirController.text = data.tanggalLahir!.month.toString();
      _tahunLahirController.text = data.tanggalLahir!.year.toString();
    }
    _umurController.text = data.umur?.toString() ?? '';

    _statusPerkawinan = data.statusPerkawinan;
    _statusDalamKeluarga = data.statusDalamKeluarga;
    _agama = data.agama;
    _alamatController.text = data.alamatDetail ?? '';
    _statusTinggal = data.statusTinggal;
    _desaKelController.text = data.desaKelurahan ?? '';
    _kabKotaController.text = data.kabupatenKota ?? '';
    _pendidikan = data.pendidikan;
    _pekerjaan = data.pekerjaan;
    _akseptorKb = data.akseptorKb == true ? 'Ya' : 'Tidak';
    _jenisAkseptorKbController.text = data.jenisAkseptorKb ?? '';
    _aktifPosyandu = data.aktifPosyandu == true ? 'Ya' : 'Tidak';
    _frekuensiPosyanduController.text =
        data.frekuensiPosyandu?.toString() ?? '';
    _binaBalita = data.mengikutiBinaBalita == true ? 'Ya' : 'Tidak';
    _memilikiTabungan = data.memilikiTabungan == true ? 'Ya' : 'Tidak';
    _paketTabungan = data.jenisPaketTabungan;
    _ikutPaud = data.mengikutiPaud == true ? 'Ya' : 'Tidak';
    _ikutKoperasi = data.ikutKoperasi == true ? 'Ya' : 'Tidak';
    _berkebutuhanKhusus = data.berkebutuhanKhusus == true ? 'Ya' : 'Tidak';
  }

  Future<void> _simpanData() async {
    if (_namaController.text.trim().isEmpty) {
      _showError('Nama harus diisi');
      return;
    }

    if (_selectedKeluarga == null) {
      _showError('Pilih keluarga terlebih dahulu');
      return;
    }

    // FIXED: Check NIK validation before saving
    if (_nikValidationError != null) {
      _showError('Perbaiki error NIK terlebih dahulu: $_nikValidationError');
      return;
    }

    if (_noKtpNikController.text.isNotEmpty && _isValidatingNik) {
      _showError('Tunggu validasi NIK selesai');
      return;
    }

    if (_jenisKelamin != null && !['L', 'P'].contains(_jenisKelamin)) {
      _showError('Jenis kelamin tidak valid');
      return;
    }

    setState(() => _isLoading = true);

    try {
      DateTime? tanggalLahir;
      if (_tanggalLahirController.text.isNotEmpty &&
          _bulanLahirController.text.isNotEmpty &&
          _tahunLahirController.text.isNotEmpty) {
        try {
          final day = int.parse(_tanggalLahirController.text);
          final month = int.parse(_bulanLahirController.text);
          final year = int.parse(_tahunLahirController.text);
          tanggalLahir = DateTime(year, month, day);
        } catch (e) {
          // Ignore parsing error
        }
      }

      final anggota = AnggotaKeluarga(
        id: widget.initial?.id,
        keluargaId: _selectedKeluarga!.id!,
        noRegistrasi: _noRegistrasiController.text.trim().isEmpty
            ? null
            : _noRegistrasiController.text.trim(),
        nik: _noKtpNikController.text.trim().isEmpty
            ? null
            : _noKtpNikController.text.trim(),
        nama: _namaController.text.trim(),
        jabatan: _jabatanController.text.trim().isEmpty
            ? null
            : _jabatanController.text.trim(),
        jenisKelamin: _jenisKelamin,
        tempatLahir: _tempatLahirController.text.trim().isEmpty
            ? null
            : _tempatLahirController.text.trim(),
        tanggalLahir: tanggalLahir,
        umur: int.tryParse(_umurController.text),
        statusPerkawinan: _statusPerkawinan,
        statusDalamKeluarga: _statusDalamKeluarga,
        agama: _agama,
        alamatDetail: _alamatController.text.trim().isEmpty
            ? null
            : _alamatController.text.trim(),
        statusTinggal: _statusTinggal,
        desaKelurahan: _desaKelController.text.trim().isEmpty
            ? null
            : _desaKelController.text.trim(),
        kabupatenKota: _kabKotaController.text.trim().isEmpty
            ? null
            : _kabKotaController.text.trim(),
        pendidikan: _pendidikan,
        pekerjaan: _pekerjaan,
        akseptorKb: _akseptorKb == 'Ya',
        jenisAkseptorKb: _jenisAkseptorKbController.text.trim().isEmpty
            ? null
            : _jenisAkseptorKbController.text.trim(),
        aktifPosyandu: _aktifPosyandu == 'Ya',
        frekuensiPosyandu: int.tryParse(_frekuensiPosyanduController.text) ?? 0,
        mengikutiBinaBalita: _binaBalita == 'Ya',
        memilikiTabungan: _memilikiTabungan == 'Ya',
        jenisPaketTabungan: _paketTabungan,
        mengikutiPaud: _ikutPaud == 'Ya',
        ikutKoperasi: _ikutKoperasi == 'Ya',
        berkebutuhanKhusus: _berkebutuhanKhusus == 'Ya',
      );

      if (widget.initial != null) {
        await AnggotaKeluargaService.updateAnggota(
          widget.initial!.id!,
          anggota,
        );
        _showSuccess('Data warga berhasil diperbarui!');
      } else {
        await AnggotaKeluargaService.createAnggota(anggota);
        _showSuccess('Data warga berhasil disimpan!');
      }

      Navigator.pop(context, true);
    } catch (e) {
      _showError('Gagal menyimpan data: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _hapusData() async {
    if (widget.initial?.id == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus data warga ini?',
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
      setState(() => _isLoading = true);
      try {
        await AnggotaKeluargaService.deleteAnggota(widget.initial!.id!);
        _showSuccess('Data warga berhasil dihapus!');
        Navigator.pop(context, true);
      } catch (e) {
        _showError('Gagal menghapus data: $e');
      }
      setState(() => _isLoading = false);
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

  // UI Builder Methods
  Widget _buildTwoColRow({
    required String label,
    required Widget right,
    double labelTopOffset = _labelTopOffset,
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

  Widget _dottedUnderline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 1,
          child: CustomPaint(
            size: Size(constraints.maxWidth, 1),
            painter: _DashedPainter(
              color: _dotColor,
              dashWidth: 3,
              dashGap: 4,
              thickness: 1,
            ),
          ),
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
      labelTopOffset: _labelTopOffset,
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder ?? '',
              hintStyle: TextStyle(
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
      labelTopOffset: _labelTopOffset,
      rowAlign: rowAlign,
      showColon: showColon,
      right: Wrap(
        spacing: 12,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: options.map((option) {
          return InkWell(
            onTap: () => onChanged(value == option ? null : option),
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
                    child: value == option
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
                      color: Colors.black,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildJenisKelaminCheckbox() {
    return _buildTwoColRow(
      label: '5. Jenis Kelamin',
      labelTopOffset: _labelTopOffset,
      right: Wrap(
        spacing: 12,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          InkWell(
            onTap: () => setState(
              () => _jenisKelamin = _jenisKelamin == 'L' ? null : 'L',
            ),
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
                    child: _jenisKelamin == 'L'
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
                  const Text(
                    'Laki-laki',
                    style: TextStyle(
                      fontSize: _valueFontSize,
                      color: Colors.black,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(
              () => _jenisKelamin = _jenisKelamin == 'P' ? null : 'P',
            ),
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
                    child: _jenisKelamin == 'P'
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
                  const Text(
                    'Perempuan',
                    style: TextStyle(
                      fontSize: _valueFontSize,
                      color: Colors.black,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeluargaDropdown() {
    if (_isWarga) {
      return _buildTwoColRow(
        label: 'Keluarga',
        right: _isLoadingKeluarga
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
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
                        _selectedKeluarga != null
                            ? '${_selectedKeluarga!.namaKepalaKeluarga} (RT: ${_selectedKeluarga!.rt ?? '-'} / RW: ${_selectedKeluarga!.rw ?? '-'})'
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
              ),
      );
    }

    return _buildTwoColRow(
      label: 'Pilih Keluarga',
      right: _isLoadingKeluarga
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: _isEditMode && _selectedKeluarga != null
                    ? Colors.grey.shade50
                    : Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Keluarga>(
                  value: _selectedKeluarga,
                  hint: Text(
                    _isEditMode
                        ? 'Memuat data keluarga...'
                        : 'Pilih keluarga...',
                    style: TextStyle(
                      color: _dotColor,
                      fontSize: _valueFontSize,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  isExpanded: true,
                  items: _keluargaList.map((keluarga) {
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
                  onChanged: (Keluarga? value) {
                    setState(() {
                      _selectedKeluarga = value;
                      if (value != null) {
                        _namaKepalaController.text = value.namaKepalaKeluarga;
                        _desaWismaController.text =
                            'Desa Wisma ${value.desaWismaId ?? ''}';
                      }
                    });
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildDateInput() {
    return _buildTwoColRow(
      label: '7. Tgl Lahir / Umur',
      labelTopOffset: _labelTopOffset,
      right: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                TextField(
                  controller: _tanggalLahirController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Tgl',
                    hintStyle: TextStyle(
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
                  textAlign: TextAlign.center,
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const Text('/', style: TextStyle(fontSize: _valueFontSize)),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                TextField(
                  controller: _bulanLahirController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Bln',
                    hintStyle: TextStyle(
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
                  textAlign: TextAlign.center,
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const Text('/', style: TextStyle(fontSize: _valueFontSize)),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                TextField(
                  controller: _tahunLahirController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Thn',
                    hintStyle: TextStyle(
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
                  textAlign: TextAlign.center,
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Umur',
            style: TextStyle(
              fontSize: _valueFontSize,
              color: Colors.black,
              fontFamily: _fontFamily,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                TextField(
                  controller: _umurController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '....',
                    hintStyle: TextStyle(
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
                  textAlign: TextAlign.center,
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Tahun',
            style: TextStyle(
              fontSize: _valueFontSize,
              color: Colors.black,
              fontFamily: _fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencyInput() {
    return _buildTwoColRow(
      label: 'Frekuensi / volume',
      labelTopOffset: _labelTopOffset,
      right: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _frekuensiPosyanduController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '1',
                    hintStyle: TextStyle(
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
                  textAlign: TextAlign.center,
                ),
                _dottedUnderline(),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Kali',
            style: TextStyle(
              fontSize: _valueFontSize,
              color: Colors.black,
              fontFamily: _fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNikInput() {
    return _buildTwoColRow(
      label: '2. No. KTP/NIK',
      labelTopOffset: _labelTopOffset,
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _noKtpNikController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            decoration: InputDecoration(
              hintText: 'Nomor KTP / NIK (16 digit)',
              hintStyle: TextStyle(
                color: _dotColor,
                fontSize: _valueFontSize,
                fontFamily: _fontFamily,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              counterText: '', // Hide character counter
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 61,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.initial != null ? 'Edit Data Warga' : 'Data Warga',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeluargaDropdown(),
                  const SizedBox(height: _gapMedium),

                  _buildDottedInput(
                    'Desa Wisma',
                    _desaWismaController,
                    placeholder: 'Masukan Mawar',
                  ),
                  const SizedBox(height: _gapSmall),
                  _buildDottedInput(
                    'Nama Kepala',
                    _namaKepalaController,
                    placeholder: 'Masukan Kepala Keluarga',
                  ),
                  const SizedBox(height: _gapMedium),
                  const Text(
                    'Rumah Tangga',
                    style: TextStyle(
                      fontSize: _labelFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: _gapSmall),
                  Padding(
                    padding: _sectionPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDottedInput(
                          '1. No. Registrasi',
                          _noRegistrasiController,
                          placeholder: 'Nomor Kepala Keluarga',
                        ),
                        const SizedBox(height: _gapSmall),
                        _buildNikInput(),
                        const SizedBox(height: _gapSmall),
                        _buildDottedInput(
                          '3. Nama',
                          _namaController,
                          placeholder: 'Nama anggota keluarga',
                        ),
                        const SizedBox(height: _gapSmall),
                        _buildDottedInput(
                          '4. Jabatan',
                          _jabatanController,
                          placeholder: 'Jabatan dalam keluarga',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildJenisKelaminCheckbox(),
                  const SizedBox(height: _gapMedium),
                  _buildDottedInput(
                    '6. Tempat Lahir',
                    _tempatLahirController,
                    placeholder: 'Cth Purwokerto',
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildDateInput(),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '8. Status Perkawinan',
                    ['Menikah', 'Lajang', 'Janda', 'Duda'],
                    _statusPerkawinan,
                    (value) => setState(() => _statusPerkawinan = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: 16),
                  _buildCheckboxGroup(
                    '9. Status Dalam Keluarga',
                    ['Kepala Keluarga', 'Anggota Keluarga'],
                    _statusDalamKeluarga,
                    (value) => setState(() => _statusDalamKeluarga = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: 16),
                  _buildCheckboxGroup(
                    '10. Agama',
                    [
                      'Islam',
                      'Kristen',
                      'Konhucu',
                      'Hindu',
                      'Katolik',
                      'Budha',
                    ],
                    _agama,
                    (value) => setState(() => _agama = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '11. Alamat',
                    style: TextStyle(
                      fontSize: _labelFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: _gapSmall),
                  Padding(
                    padding: _sectionPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDottedInput(
                          'Alamat',
                          _alamatController,
                          placeholder: 'Alamat anda',
                        ),
                        const SizedBox(height: _gapSmall),
                        _buildCheckboxGroup(
                          'Status Tinggal',
                          ['Mukim', 'Perantauan'],
                          _statusTinggal,
                          (value) => setState(() => _statusTinggal = value),
                        ),
                        const SizedBox(height: _gapSmall),
                        _buildDottedInput(
                          'Desa / Kel / Sejenis',
                          _desaKelController,
                          placeholder: 'Cth. Pandak',
                        ),
                        const SizedBox(height: _gapSmall),
                        _buildDottedInput(
                          'Kab / Kota',
                          _kabKotaController,
                          placeholder: 'Cth. Banyumas',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '12. Pendidikan',
                    [
                      'Tidak tamat sd',
                      'SD / MI',
                      'SMP / Sederajat',
                      'SMU / SMK / Sederajat',
                      'Diploma',
                      'S1',
                      'S2',
                      'S3',
                    ],
                    _pendidikan,
                    (value) => setState(() => _pendidikan = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '13. Pekerjaan',
                    [
                      'Petani',
                      'Pedagang',
                      'Wirausaha',
                      'Swasta',
                      'TNI / Polri',
                      'Lainnya',
                    ],
                    _pekerjaan,
                    (value) => setState(() => _pekerjaan = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '14. Akseptor KB',
                    ['Ya', 'Tidak'],
                    _akseptorKb,
                    (value) => setState(() => _akseptorKb = value),
                  ),
                  const SizedBox(height: _gapSmall),
                  if (_akseptorKb == 'Ya')
                    Padding(
                      padding: _sectionPadding,
                      child: _buildDottedInput(
                        'Jenis Akseptor KB',
                        _jenisAkseptorKbController,
                        placeholder: 'Kondom Sutra Merah',
                      ),
                    ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '15. Aktif dalam Posyandu',
                    ['Ya', 'Tidak'],
                    _aktifPosyandu,
                    (value) => setState(() => _aktifPosyandu = value),
                  ),
                  const SizedBox(height: _gapSmall),
                  if (_aktifPosyandu == 'Ya')
                    Padding(
                      padding: _sectionPadding,
                      child: _buildFrequencyInput(),
                    ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '16. Mengikuti program bina keluarga balita',
                    ['Ya', 'Tidak'],
                    _binaBalita,
                    (value) => setState(() => _binaBalita = value),
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '17. Memiliki Tabungan',
                    ['Ya', 'Tidak'],
                    _memilikiTabungan,
                    (value) => setState(() => _memilikiTabungan = value),
                    rowAlign: CrossAxisAlignment.start,
                  ),
                  const SizedBox(height: _gapSmall),
                  if (_memilikiTabungan == 'Ya')
                    Padding(
                      padding: _sectionPadding,
                      child: _buildCheckboxGroup(
                        '',
                        ['Paket A', 'Paket B', 'Paket C', 'KF'],
                        _paketTabungan,
                        (value) => setState(() => _paketTabungan = value),
                        rowAlign: CrossAxisAlignment.start,
                        showColon: false,
                      ),
                    ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '18. Mengikuti PAUD',
                    ['Ya', 'Tidak'],
                    _ikutPaud,
                    (value) => setState(() => _ikutPaud = value),
                  ),
                  const SizedBox(height: _gapMedium),
                  _buildCheckboxGroup(
                    '19. Ikut dalam kegiatan koperasi',
                    ['Ya', 'Tidak'],
                    _ikutKoperasi,
                    (value) => setState(() => _ikutKoperasi = value),
                  ),
                  const SizedBox(height: 16),
                  _buildCheckboxGroup(
                    '20. Berkebutuhan Khusus',
                    ['Ya', 'Tidak'],
                    _berkebutuhanKhusus,
                    (value) => setState(() => _berkebutuhanKhusus = value),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.initial != null)
                        OutlinedButton.icon(
                          onPressed: _hapusData,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFD32F2F),
                              width: 2,
                            ),
                            foregroundColor: const Color(0xFFD32F2F),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text(
                            'Hapus Data',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ElevatedButton.icon(
                        onPressed: _simpanData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3669),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
