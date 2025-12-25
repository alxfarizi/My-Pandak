class Warga {
  final int? id;
  final String nama;
  final String mawar;
  final String nik;
  final String? namaKepala;
  final String? noRegistrasi;
  final String? jabatan;
  final String? jenisKelamin;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? bulanLahir;
  final String? tahunLahir;
  final String? umur;
  final String? desaKel;
  final String? kabKota;
  final String? alamat;
  final String? statusPerkawinan;
  final String? statusDalamKeluarga;
  final String? agama;
  final String? statusTinggal;
  final String? pendidikan;
  final String? pekerjaan;
  final String? akseptorKb;
  final String? jenisAkseptorKb;
  final String? aktifPosyandu;
  final String? frekuensiPosyandu;
  final String? binaBalita;
  final String? memilikiTabungan;
  final String? paketTabungan;
  final String? ikutPaud;
  final String? ikutKoperasi;
  final String? berkebutuhanKhusus;

  Warga({
    this.id,
    required this.nama,
    required this.mawar,
    required this.nik,
    this.namaKepala,
    this.noRegistrasi,
    this.jabatan,
    this.jenisKelamin,
    this.tempatLahir,
    this.tanggalLahir,
    this.bulanLahir,
    this.tahunLahir,
    this.umur,
    this.desaKel,
    this.kabKota,
    this.alamat,
    this.statusPerkawinan,
    this.statusDalamKeluarga,
    this.agama,
    this.statusTinggal,
    this.pendidikan,
    this.pekerjaan,
    this.akseptorKb,
    this.jenisAkseptorKb,
    this.aktifPosyandu,
    this.frekuensiPosyandu,
    this.binaBalita,
    this.memilikiTabungan,
    this.paketTabungan,
    this.ikutPaud,
    this.ikutKoperasi,
    this.berkebutuhanKhusus,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'mawar': mawar,
        'nik': nik,
        'namaKepala': namaKepala,
        'noRegistrasi': noRegistrasi,
        'jabatan': jabatan,
        'jenisKelamin': jenisKelamin,
        'tempatLahir': tempatLahir,
        'tanggalLahir': tanggalLahir,
        'bulanLahir': bulanLahir,
        'tahunLahir': tahunLahir,
        'umur': umur,
        'desaKel': desaKel,
        'kabKota': kabKota,
        'alamat': alamat,
        'statusPerkawinan': statusPerkawinan,
        'statusDalamKeluarga': statusDalamKeluarga,
        'agama': agama,
        'statusTinggal': statusTinggal,
        'pendidikan': pendidikan,
        'pekerjaan': pekerjaan,
        'akseptorKb': akseptorKb,
        'jenisAkseptorKb': jenisAkseptorKb,
        'aktifPosyandu': aktifPosyandu,
        'frekuensiPosyandu': frekuensiPosyandu,
        'binaBalita': binaBalita,
        'memilikiTabungan': memilikiTabungan,
        'paketTabungan': paketTabungan,
        'ikutPaud': ikutPaud,
        'ikutKoperasi': ikutKoperasi,
        'berkebutuhanKhusus': berkebutuhanKhusus,
      };

  static Warga fromMap(Map<String, dynamic> m) => Warga(
        id: m['id'] as int?,
        nama: (m['nama'] ?? '') as String,
        mawar: (m['mawar'] ?? '') as String,
        nik: (m['nik'] ?? '') as String,
        namaKepala: m['namaKepala'] as String?,
        noRegistrasi: m['noRegistrasi'] as String?,
        jabatan: m['jabatan'] as String?,
        jenisKelamin: m['jenisKelamin'] as String?,
        tempatLahir: m['tempatLahir'] as String?,
        tanggalLahir: m['tanggalLahir'] as String?,
        bulanLahir: m['bulanLahir'] as String?,
        tahunLahir: m['tahunLahir'] as String?,
        umur: m['umur'] as String?,
        desaKel: m['desaKel'] as String?,
        kabKota: m['kabKota'] as String?,
        alamat: m['alamat'] as String?,
        statusPerkawinan: m['statusPerkawinan'] as String?,
        statusDalamKeluarga: m['statusDalamKeluarga'] as String?,
        agama: m['agama'] as String?,
        statusTinggal: m['statusTinggal'] as String?,
        pendidikan: m['pendidikan'] as String?,
        pekerjaan: m['pekerjaan'] as String?,
        akseptorKb: m['akseptorKb'] as String?,
        jenisAkseptorKb: m['jenisAkseptorKb'] as String?,
        aktifPosyandu: m['aktifPosyandu'] as String?,
        frekuensiPosyandu: m['frekuensiPosyandu'] as String?,
        binaBalita: m['binaBalita'] as String?,
        memilikiTabungan: m['memilikiTabungan'] as String?,
        paketTabungan: m['paketTabungan'] as String?,
        ikutPaud: m['ikutPaud'] as String?,
        ikutKoperasi: m['ikutKoperasi'] as String?,
        berkebutuhanKhusus: m['berkebutuhanKhusus'] as String?,
      );
}
