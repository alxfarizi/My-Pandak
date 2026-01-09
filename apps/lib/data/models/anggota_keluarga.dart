//anggota_keluarga.dart
class AnggotaKeluarga {
  final int? id;
  final int keluargaId;
  final String? noRegistrasi;
  final String? nik;
  final String nama;
  final String? jabatan;
  final String? jenisKelamin;
  final String? tempatLahir;
  final DateTime? tanggalLahir;
  final int? umur;
  final String? statusPerkawinan;
  final String? statusDalamKeluarga;
  final String? agama;
  final String? alamatDetail;
  final String? statusTinggal;
  final String? desaKelurahan;
  final String? kabupatenKota;
  final String? pendidikan;
  final String? pekerjaan;
  final bool akseptorKb;
  final String? jenisAkseptorKb;
  final bool aktifPosyandu;
  final int frekuensiPosyandu;
  final bool mengikutiBinaBalita;
  final bool memilikiTabungan;
  final String? jenisPaketTabungan;
  final bool mengikutiPaud;
  final bool ikutKoperasi;
  final bool berkebutuhanKhusus;
  final String? jenisKebutuhanKhusus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AnggotaKeluarga({
    this.id,
    required this.keluargaId,
    this.noRegistrasi,
    this.nik,
    required this.nama,
    this.jabatan,
    this.jenisKelamin,
    this.tempatLahir,
    this.tanggalLahir,
    this.umur,
    this.statusPerkawinan,
    this.statusDalamKeluarga,
    this.agama,
    this.alamatDetail,
    this.statusTinggal,
    this.desaKelurahan,
    this.kabupatenKota,
    this.pendidikan,
    this.pekerjaan,
    this.akseptorKb = false,
    this.jenisAkseptorKb,
    this.aktifPosyandu = false,
    this.frekuensiPosyandu = 0,
    this.mengikutiBinaBalita = false,
    this.memilikiTabungan = false,
    this.jenisPaketTabungan,
    this.mengikutiPaud = false,
    this.ikutKoperasi = false,
    this.berkebutuhanKhusus = false,
    this.jenisKebutuhanKhusus,
    this.createdAt,
    this.updatedAt,
  });

  factory AnggotaKeluarga.fromJson(Map<String, dynamic> json) {
    return AnggotaKeluarga(
      id: json['id'],
      keluargaId: json['keluarga_id'],
      noRegistrasi: json['no_registrasi'],
      nik: json['nik'],
      nama: json['nama'] ?? '',
      jabatan: json['jabatan'],
      jenisKelamin: json['jenis_kelamin'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'] != null ? DateTime.parse(json['tanggal_lahir']) : null,
      umur: json['umur'],
      statusPerkawinan: json['status_perkawinan'],
      statusDalamKeluarga: json['status_dalam_keluarga'],
      agama: json['agama'],
      alamatDetail: json['alamat_detail'],
      statusTinggal: json['status_tinggal'],
      desaKelurahan: json['desa_kelurahan'],
      kabupatenKota: json['kabupaten_kota'],
      pendidikan: json['pendidikan'],
      pekerjaan: json['pekerjaan'],
      akseptorKb: json['akseptor_kb'] ?? false,
      jenisAkseptorKb: json['jenis_akseptor_kb'],
      aktifPosyandu: json['aktif_posyandu'] ?? false,
      frekuensiPosyandu: json['frekuensi_posyandu'] ?? 0,
      mengikutiBinaBalita: json['mengikuti_bina_balita'] ?? false,
      memilikiTabungan: json['memiliki_tabungan'] ?? false,
      jenisPaketTabungan: json['jenis_paket_tabungan'],
      mengikutiPaud: json['mengikuti_paud'] ?? false,
      ikutKoperasi: json['ikut_koperasi'] ?? false,
      berkebutuhanKhusus: json['berkebutuhan_khusus'] ?? false,
      jenisKebutuhanKhusus: json['jenis_kebutuhan_khusus'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'keluarga_id': keluargaId,
      'nama': nama,
      // Hanya include field yang tidak null atau yang memiliki default value
    };

    // Optional fields - hanya include jika tidak null/empty
    if (noRegistrasi?.isNotEmpty == true) data['no_registrasi'] = noRegistrasi;
    if (nik?.isNotEmpty == true) data['nik'] = nik;
    if (jabatan?.isNotEmpty == true) data['jabatan'] = jabatan;
    if (jenisKelamin?.isNotEmpty == true) data['jenis_kelamin'] = jenisKelamin;
    if (tempatLahir?.isNotEmpty == true) data['tempat_lahir'] = tempatLahir;
    if (tanggalLahir != null) data['tanggal_lahir'] = tanggalLahir!.toIso8601String().split('T')[0];
    if (umur != null) data['umur'] = umur;
    if (statusPerkawinan?.isNotEmpty == true) data['status_perkawinan'] = statusPerkawinan;
    if (statusDalamKeluarga?.isNotEmpty == true) data['status_dalam_keluarga'] = statusDalamKeluarga;
    if (agama?.isNotEmpty == true) data['agama'] = agama;
    if (alamatDetail?.isNotEmpty == true) data['alamat_detail'] = alamatDetail;
    if (statusTinggal?.isNotEmpty == true) data['status_tinggal'] = statusTinggal;
    if (desaKelurahan?.isNotEmpty == true) data['desa_kelurahan'] = desaKelurahan;
    if (kabupatenKota?.isNotEmpty == true) data['kabupaten_kota'] = kabupatenKota;
    if (pendidikan?.isNotEmpty == true) data['pendidikan'] = pendidikan;
    if (pekerjaan?.isNotEmpty == true) data['pekerjaan'] = pekerjaan;

    // Boolean fields - selalu include dengan default value
    data['akseptor_kb'] = akseptorKb;
    data['aktif_posyandu'] = aktifPosyandu;
    data['mengikuti_bina_balita'] = mengikutiBinaBalita;
    data['memiliki_tabungan'] = memilikiTabungan;
    data['mengikuti_paud'] = mengikutiPaud;
    data['ikut_koperasi'] = ikutKoperasi;
    data['berkebutuhan_khusus'] = berkebutuhanKhusus;

    if (jenisAkseptorKb?.isNotEmpty == true) data['jenis_akseptor_kb'] = jenisAkseptorKb;
    data['frekuensi_posyandu'] = frekuensiPosyandu;
    if (jenisPaketTabungan?.isNotEmpty == true) data['jenis_paket_tabungan'] = jenisPaketTabungan;
    if (jenisKebutuhanKhusus?.isNotEmpty == true) data['jenis_kebutuhan_khusus'] = jenisKebutuhanKhusus;

    // PENTING: JANGAN include 'id' untuk insert baru
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

}
