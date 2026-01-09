//preview_data_warga_page.dart - DATA SYNC FIX
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
                              // FIXED: Use real data from wargaData
                              _buildFormRow(
                                'Desa Wisma',
                                wargaData['mawar'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildFormRow(
                                'Nama Kepala Rumah Tangga',
                                wargaData['namaKepalaKeluarga'] ?? '',
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildFormRow('Dusun', wargaData['dusun'] ?? ''),
                              SizedBox(height: _vspaceXS),
                              _buildFormRow(
                                'RT/RW',
                                '${wargaData['rt'] ?? ''}/${wargaData['rw'] ?? ''}',
                              ),
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
                                _buildKBOptions(),
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
                                _buildBinaBalitaOptions(),
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
                                _buildYesNoOptions('mengikutiKelompokBelajar'),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                18,
                                'Mengikuti PAUD',
                                _buildPAUDOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                19,
                                'Ikut dalam kegiatan koperasi',
                                _buildKoperasiOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                20,
                                'Berkebutuhan Khusus',
                                _buildKebutuhanKhususOptions(),
                              ),
                              SizedBox(height: _vspaceXS),
                              _buildNumberedFormRowWithWidget(
                                21,
                                'Frekuensi / Volume',
                                _buildFrequencyVolume(),
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

  // FIXED: Use real data for gender options
  Widget _buildGenderOptions() {
    final jenisKelamin = wargaData['jenisKelamin'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Laki-laki', jenisKelamin == 'Laki-laki'),
        const SizedBox(width: 8),
        _buildCheckbox('Perempuan', jenisKelamin == 'Perempuan'),
      ],
    );
  }

  // FIXED: Use real data for date and age
  Widget _buildDateAndAge() {
    final tanggalLahir = wargaData['tanggalLahir'] ?? '';
    final umur = wargaData['umur'] ?? '';

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (tanggalLahir.isNotEmpty)
          Text(
            tanggalLahir,
            style: const TextStyle(
              fontSize: 5,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        if (umur.isNotEmpty) ...[
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
      ],
    );
  }

  // FIXED: Use real data for marital status
  Widget _buildMaritalStatus() {
    final status = wargaData['statusPerkawinan'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox('Menikah', status == 'Menikah'),
            const SizedBox(width: 8),
            _buildCheckbox('Belum kawin', status == 'Lajang'),
            const SizedBox(width: 8),
            _buildCheckbox('Cerai hidup', status == 'Cerai hidup'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('Cerai mati', status == 'Cerai mati'),
            const SizedBox(width: 8),
            _buildCheckbox('Duda', status == 'Duda'),
            const SizedBox(width: 8),
            _buildCheckbox('Janda', status == 'Janda'),
          ],
        ),
      ],
    );
  }

  // FIXED: Use real data for family status
  Widget _buildFamilyStatus() {
    final status = wargaData['statusDalamKeluarga'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox('Kepala Keluarga', status == 'Kepala Keluarga'),
            const SizedBox(width: 8),
            _buildCheckbox('Anggota Keluarga', status == 'Anggota Keluarga'),
          ],
        ),
        const SizedBox(height: 4),
        Row(children: [_buildCheckbox('Menantu', status == 'Menantu')]),
      ],
    );
  }

  // FIXED: Use real data for religion
  Widget _buildReligionOptions() {
    final agama = wargaData['agama'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox('Islam', agama == 'Islam'),
            const SizedBox(width: 8),
            _buildCheckbox('Kristen', agama == 'Kristen'),
            const SizedBox(width: 8),
            _buildCheckbox('Katolik', agama == 'Katolik'),
            const SizedBox(width: 8),
            _buildCheckbox('Hindu', agama == 'Hindu'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('Buddha', agama == 'Budha'),
            const SizedBox(width: 8),
            _buildCheckbox('Khonghucu', agama == 'Konhucu'),
          ],
        ),
      ],
    );
  }

  // FIXED: Use real data for education
  Widget _buildEducationOptions() {
    final pendidikan = wargaData['pendidikan'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox(
              'Tidak/Belum Sekolah',
              pendidikan == 'Tidak tamat sd',
            ),
            const SizedBox(width: 8),
            _buildCheckbox('SD/MI/Sederajat', pendidikan == 'SD / MI'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox(
              'SMP/MTs/Sederajat',
              pendidikan == 'SMP / Sederajat',
            ),
            const SizedBox(width: 8),
            _buildCheckbox(
              'SMA/SMK/MA/Sederajat',
              pendidikan == 'SMU / SMK / Sederajat',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('Diploma', pendidikan == 'Diploma'),
            const SizedBox(width: 8),
            _buildCheckbox('S1', pendidikan == 'S1'),
            const SizedBox(width: 8),
            _buildCheckbox('S2', pendidikan == 'S2'),
            const SizedBox(width: 8),
            _buildCheckbox('S3', pendidikan == 'S3'),
          ],
        ),
      ],
    );
  }

  // FIXED: Use real data for job
  Widget _buildJobOptions() {
    final pekerjaan = wargaData['pekerjaan'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCheckbox('Pelajar/Mahasiswa', pekerjaan == 'Pelajar'),
            const SizedBox(width: 8),
            _buildCheckbox('Petani', pekerjaan == 'Petani'),
            const SizedBox(width: 8),
            _buildCheckbox('Buruh', pekerjaan == 'Buruh'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('Pedagang', pekerjaan == 'Pedagang'),
            const SizedBox(width: 8),
            _buildCheckbox('Wiraswasta', pekerjaan == 'Wirausaha'),
            const SizedBox(width: 8),
            _buildCheckbox('PNS', pekerjaan == 'PNS'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildCheckbox('TNI', pekerjaan == 'TNI / Polri'),
            const SizedBox(width: 8),
            _buildCheckbox('Polri', pekerjaan == 'TNI / Polri'),
            const SizedBox(width: 8),
            _buildCheckbox('Nelayan', pekerjaan == 'Nelayan'),
          ],
        ),
        const SizedBox(height: 4),
        Row(children: [_buildCheckbox('Ibu Rumah Tangga', pekerjaan == 'IRT')]),
      ],
    );
  }

  // FIXED: Use real data for KB
  Widget _buildKBOptions() {
    final akseptorKb = wargaData['akseptorKb'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', akseptorKb == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', akseptorKb == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for Posyandu
  Widget _buildPosyanduOptions() {
    final aktifPosyandu = wargaData['aktifPosyandu'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', aktifPosyandu == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', aktifPosyandu == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for Bina Balita
  Widget _buildBinaBalitaOptions() {
    final binaBalita = wargaData['mengikutiBinaBalita'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', binaBalita == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', binaBalita == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for Tabungan
  Widget _buildTabunganOptions() {
    final tabungan = wargaData['memilikiTabungan'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', tabungan == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', tabungan == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for PAUD
  Widget _buildPAUDOptions() {
    final paud = wargaData['mengikutiPaud'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', paud == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', paud == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for Koperasi
  Widget _buildKoperasiOptions() {
    final koperasi = wargaData['ikutKoperasi'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', koperasi == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', koperasi == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for Kebutuhan Khusus
  Widget _buildKebutuhanKhususOptions() {
    final kebutuhanKhusus = wargaData['berkebutuhanKhusus'] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', kebutuhanKhusus == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', kebutuhanKhusus == 'Tidak'),
      ],
    );
  }

  Widget _buildYesNoOptions(String key) {
    final value = wargaData[key] ?? '';
    return Row(
      children: [
        _buildCheckbox('Ya', value == 'Ya'),
        const SizedBox(width: 8),
        _buildCheckbox('Tidak', value == 'Tidak'),
      ],
    );
  }

  // FIXED: Use real data for frequency
  Widget _buildFrequencyVolume() {
    final frekuensi = wargaData['frekuensiPosyandu'] ?? '1';
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          frekuensi,
          style: const TextStyle(
            fontSize: 5,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        const Text(
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

  Widget _buildCheckbox(String label, [bool checked = false]) {
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
