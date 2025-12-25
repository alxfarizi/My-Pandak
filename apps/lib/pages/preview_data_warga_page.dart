import 'package:flutter/material.dart';

class PreviewDataWargaPage extends StatelessWidget {
  final Map<String, String> wargaData;
  static const double _labelWidth = 80;
  static const double _colonWidth = 1;
  static const double _afterColonSpacing = 5;
  static const double _paperWidth = 298;
  static const double _vspaceXS = 6;
  static const double _vspaceS = 8;
  static const double _numberWidth = 10;
  const PreviewDataWargaPage({super.key, required this.wargaData});

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
            child: const Icon(Icons.people, color: Colors.white, size: 23),
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
                child: Center(
                  child: Container(
                    width: _paperWidth,
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
                        const Center(
                          child: Text(
                            'Data Warga',
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        SizedBox(height: _vspaceS),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormRow(
                                'Desa Wisma',
                                wargaData['mawar'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildFormRow(
                                'Nama Kepala Rumah Tangga',
                                wargaData['nama'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildFormRow('Rumah Tangga', ''),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRow(
                                1,
                                'No. KTP/NIK',
                                wargaData['nik'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRow(
                                2,
                                'Nama',
                                wargaData['nama'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRow(
                                3,
                                'Jabatan',
                                wargaData['jabatan'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                4,
                                'Jenis Kelamin',
                                _buildGenderOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                5,
                                'Tgl Lahir / Umur',
                                _buildDateAndAge(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRow(
                                6,
                                'Tempat Lahir',
                                wargaData['tempatLahir'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                7,
                                'Status Perkawinan',
                                _buildMaritalStatus(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                8,
                                'Status Dalam Keluarga',
                                _buildFamilyStatus(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                9,
                                'Agama',
                                _buildReligionOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRow(
                                10,
                                'Alamat',
                                wargaData['alamat'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                11,
                                'Pendidikan',
                                _buildEducationOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                12,
                                'Pekerjaan',
                                _buildJobOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                13,
                                'Akseptor KB',
                                _buildYesNoOptionsFor('akseptorKb'),
                              ),
                              SizedBox(height: _vspaceS),
                              _buildNumberedFormRowWithWidget(
                                14,
                                'Aktif dalam Posyandu',
                                _buildPosyanduOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                15,
                                'Mengikuti Program Bina Keluarga Balita',
                                _buildYesNoOptionsFor('binaBalita'),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                16,
                                'Memiliki Tabungan',
                                _buildTabunganOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                17,
                                'Mengikuti Kelompok Belajar',
                                _buildYesNoOptionsFor('kelompokBelajar'),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                18,
                                'Mengikuti PAUD',
                                _buildYesNoOptionsFor('ikutPaud'),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                19,
                                'Ikut dalam kegiatan koperasi',
                                _buildYesNoOptionsFor('ikutKoperasi'),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                20,
                                'Berkebutuhan Khusus',
                                _buildYesNoOptionsFor('berkebutuhanKhusus'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: _vspaceS),
                        Container(
                          color: const Color(0xFFA3A3A3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '1/1',
                                style: TextStyle(
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
                ),
              ),
            ),
          ],
        ),
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
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildNumberedFormRow(int no, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumber('$no.'),
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
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
              fontFamily: 'Poppins',
            ),
          ),
        ),
        if (value.isNotEmpty) ...[
          SizedBox(width: _afterColonSpacing),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 5,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNumberedFormRowWithWidget(
    int no,
    String label,
    Widget trailing,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumber('$no.'),
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
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
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(width: _afterColonSpacing),
        Expanded(child: trailing),
      ],
    );
  }

  Widget _buildFormRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
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
              fontFamily: 'Poppins',
            ),
          ),
        ),
        if (value.isNotEmpty) ...[
          SizedBox(width: _afterColonSpacing),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 5,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGenderOptions() {
    final g = wargaData['jenisKelamin'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Laki-laki', g == 'Laki-laki'),
        const SizedBox(width: 8),
        _buildCheckbox('Perempuan', g == 'Perempuan'),
      ],
    );
  }

  Widget _buildDateAndAge() {
    final tgl = wargaData['tanggalLahir'] ?? '';
    final bln = wargaData['bulanLahir'] ?? '';
    final thn = wargaData['tahunLahir'] ?? '';
    final dateStr = (tgl.isEmpty && bln.isEmpty && thn.isEmpty)
        ? ''
        : '$tgl/$bln/$thn';
    final umur = wargaData['umur'] ?? '';

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          dateStr,
          style: const TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          umur,
          style: const TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        const Text(
          'Tahun',
          style: TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildMaritalStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox(
              'Menikah',
              (wargaData['statusPerkawinan'] ?? '') == 'Menikah',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Belum kawin',
              (wargaData['statusPerkawinan'] ?? '') == 'Belum kawin',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Cerai hidup',
              (wargaData['statusPerkawinan'] ?? '') == 'Cerai hidup',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'Cerai mati',
              (wargaData['statusPerkawinan'] ?? '') == 'Cerai mati',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Duda',
              (wargaData['statusPerkawinan'] ?? '') == 'Duda',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Janda',
              (wargaData['statusPerkawinan'] ?? '') == 'Janda',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFamilyStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox(
              'Kepala Keluarga',
              (wargaData['statusDalamKeluarga'] ?? '') == 'Kepala Keluarga',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Anggota Keluarga',
              (wargaData['statusDalamKeluarga'] ?? '') == 'Anggota Keluarga',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'Menantu',
              (wargaData['statusDalamKeluarga'] ?? '') == 'Menantu',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReligionOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox('Islam', (wargaData['agama'] ?? '') == 'Islam'),
            const SizedBox(width: 8),
            _buildCheckbox('Kristen', (wargaData['agama'] ?? '') == 'Kristen'),
            const SizedBox(width: 8),
            _buildCheckbox('Katolik', (wargaData['agama'] ?? '') == 'Katolik'),
            const SizedBox(width: 8),
            _buildCheckbox('Hindu', (wargaData['agama'] ?? '') == 'Hindu'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('Buddha', (wargaData['agama'] ?? '') == 'Buddha'),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Khonghucu',
              (wargaData['agama'] ?? '') == 'Khonghucu',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEducationOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox(
              'Tidak/Belum Sekolah',
              (wargaData['pendidikan'] ?? '') == 'Tidak/Belum Sekolah',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'SD/MI/Sederajat',
              (wargaData['pendidikan'] ?? '') == 'SD/MI/Sederajat' ||
                  (wargaData['pendidikan'] ?? '').contains('SD'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'SMP/MTs/Sederajat',
              (wargaData['pendidikan'] ?? '') == 'SMP/MTs/Sederajat' ||
                  (wargaData['pendidikan'] ?? '').contains('SMP'),
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'SMA/SMK/MA/Sederajat',
              (wargaData['pendidikan'] ?? '') == 'SMA/SMK/MA/Sederajat' ||
                  (wargaData['pendidikan'] ?? '').contains('SMU') ||
                  (wargaData['pendidikan'] ?? '').contains('SMA') ||
                  (wargaData['pendidikan'] ?? '').contains('SMK'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'Diploma',
              (wargaData['pendidikan'] ?? '') == 'Diploma',
            ),
            const SizedBox(width: 8),
            _buildCheckbox('S1', (wargaData['pendidikan'] ?? '') == 'S1'),
            const SizedBox(width: 8),
            _buildCheckbox('S2', (wargaData['pendidikan'] ?? '') == 'S2'),
            const SizedBox(width: 8),
            _buildCheckbox('S3', (wargaData['pendidikan'] ?? '') == 'S3'),
          ],
        ),
      ],
    );
  }

  Widget _buildJobOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox(
              'Pelajar/Mahasiswa',
              (wargaData['pekerjaan'] ?? '') == 'Pelajar/Mahasiswa',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Petani',
              (wargaData['pekerjaan'] ?? '') == 'Petani',
            ),
            const SizedBox(width: 8),
            _buildCheckbox('Buruh', (wargaData['pekerjaan'] ?? '') == 'Buruh'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'Pedagang',
              (wargaData['pekerjaan'] ?? '') == 'Pedagang',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Wiraswasta',
              (wargaData['pekerjaan'] ?? '') == 'Wiraswasta' ||
                  (wargaData['pekerjaan'] ?? '') == 'Swasta',
            ),
            const SizedBox(width: 8),
            _buildCheckbox('PNS', (wargaData['pekerjaan'] ?? '') == 'PNS'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'TNI',
              (wargaData['pekerjaan'] ?? '') == 'TNI' ||
                  (wargaData['pekerjaan'] ?? '') == 'TNI / Polri',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Polri',
              (wargaData['pekerjaan'] ?? '') == 'Polri' ||
                  (wargaData['pekerjaan'] ?? '') == 'TNI / Polri',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'Nelayan',
              (wargaData['pekerjaan'] ?? '') == 'Nelayan',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'Ibu Rumah Tangga',
              (wargaData['pekerjaan'] ?? '') == 'Ibu Rumah Tangga',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYesNoOptionsFor(String key) {
    final v = (wargaData[key] ?? '').toLowerCase();
    return Row(
      children: [
        _buildCheckbox('Ya', v == 'ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', v == 'tidak' || v.isEmpty),
      ],
    );
  }

  Widget _buildPosyanduOptions() {
    final v = (wargaData['aktifPosyandu'] ?? '').toLowerCase();
    final isYes = v == 'ya';
    final freq = wargaData['frekuensiPosyandu'] ?? '';

    return Row(
      children: [
        _buildCheckbox('Ya', isYes),
        if (isYes && freq.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(
            '$freq Kali',
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ],
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', v == 'tidak' || v.isEmpty),
      ],
    );
  }

  Widget _buildTabunganOptions() {
    final v = (wargaData['memilikiTabungan'] ?? '').toLowerCase();
    final isYes = v == 'ya';
    final paket = wargaData['paketTabungan'] ?? '';

    return Row(
      children: [
        _buildCheckbox('Ya', isYes),
        if (isYes && paket.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(
            '($paket)',
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ],
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', v == 'tidak' || v.isEmpty),
      ],
    );
  }

  Widget _buildFrequencyVolume() {
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        Text(
          '1',
          style: TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          'Kali',
          style: TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, [bool selected = false]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          child: selected
              ? Center(
                  child: Container(
                    width: 4,
                    height: 4,
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
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
