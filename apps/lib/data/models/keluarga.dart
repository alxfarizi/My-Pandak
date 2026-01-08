//keluarga.dart
class Keluarga {
  final int? id;
  final int? desaWismaId;
  final String namaKepalaKeluarga;
  final String? rt;
  final String? rw;
  final String? dusun;
  final String? lingkungan;
  final String? alamat;

  // Statistik
  final int jumlahAnggota;
  final int jumlahLaki;
  final int jumlahPerempuan;
  final int jumlahKk;

  // Data khusus
  final int jumlahBalita;
  final int jumlahPus;
  final int jumlahWus;
  final int jumlahButa;
  final int jumlahIbuHamil;
  final int jumlahIbuMenyusui;
  final int jumlahLansia;
  final String? kriteriaLansia;

  // Fasilitas
  final String? makananPokok;
  final bool jambanKeluarga;
  final int jumlahJambanOrang;
  final String? sumberAir;
  final bool tempatSampah;
  final bool saluranAirLimbah;
  final bool stikerP4k;
  final String? kriteriaRumah;

  // Aktivitas
  final bool aktivitasUp2k;
  final String? jenisUsahaUp2k;
  final String? aktivitasKesehatanLingkungan;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Keluarga({
    this.id,
    this.desaWismaId,
    required this.namaKepalaKeluarga,
    this.rt,
    this.rw,
    this.dusun,
    this.lingkungan,
    this.alamat,
    this.jumlahAnggota = 0,
    this.jumlahLaki = 0,
    this.jumlahPerempuan = 0,
    this.jumlahKk = 1,
    this.jumlahBalita = 0,
    this.jumlahPus = 0,
    this.jumlahWus = 0,
    this.jumlahButa = 0,
    this.jumlahIbuHamil = 0,
    this.jumlahIbuMenyusui = 0,
    this.jumlahLansia = 0,
    this.kriteriaLansia,
    this.makananPokok,
    this.jambanKeluarga = false,
    this.jumlahJambanOrang = 0,
    this.sumberAir,
    this.tempatSampah = false,
    this.saluranAirLimbah = false,
    this.stikerP4k = false,
    this.kriteriaRumah,
    this.aktivitasUp2k = false,
    this.jenisUsahaUp2k,
    this.aktivitasKesehatanLingkungan,
    this.createdAt,
    this.updatedAt,
  });

  factory Keluarga.fromJson(Map<String, dynamic> json) {
    return Keluarga(
      id: json['id'],
      desaWismaId: json['desa_wisma_id'],
      namaKepalaKeluarga: json['nama_kepala_keluarga'] ?? '',
      rt: json['rt'],
      rw: json['rw'],
      dusun: json['dusun'],
      lingkungan: json['lingkungan'],
      alamat: json['alamat'],
      jumlahAnggota: json['jumlah_anggota'] ?? 0,
      jumlahLaki: json['jumlah_laki'] ?? 0,
      jumlahPerempuan: json['jumlah_perempuan'] ?? 0,
      jumlahKk: json['jumlah_kk'] ?? 1,
      jumlahBalita: json['jumlah_balita'] ?? 0,
      jumlahPus: json['jumlah_pus'] ?? 0,
      jumlahWus: json['jumlah_wus'] ?? 0,
      jumlahButa: json['jumlah_buta'] ?? 0,
      jumlahIbuHamil: json['jumlah_ibu_hamil'] ?? 0,
      jumlahIbuMenyusui: json['jumlah_ibu_menyusui'] ?? 0,
      jumlahLansia: json['jumlah_lansia'] ?? 0,
      kriteriaLansia: json['kriteria_lansia'],
      makananPokok: json['makanan_pokok'],
      jambanKeluarga: json['jamban_keluarga'] ?? false,
      jumlahJambanOrang: json['jumlah_jamban_orang'] ?? 0,
      sumberAir: json['sumber_air'],
      tempatSampah: json['tempat_sampah'] ?? false,
      saluranAirLimbah: json['saluran_air_limbah'] ?? false,
      stikerP4k: json['stiker_p4k'] ?? false,
      kriteriaRumah: json['kriteria_rumah'],
      aktivitasUp2k: json['aktivitas_up2k'] ?? false,
      jenisUsahaUp2k: json['jenis_usaha_up2k'],
      aktivitasKesehatanLingkungan: json['aktivitas_kesehatan_lingkungan'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'desa_wisma_id': desaWismaId,
      'nama_kepala_keluarga': namaKepalaKeluarga,
      'rt': rt,
      'rw': rw,
      'dusun': dusun,
      'lingkungan': lingkungan,
      'alamat': alamat,
      'jumlah_anggota': jumlahAnggota,
      'jumlah_laki': jumlahLaki,
      'jumlah_perempuan': jumlahPerempuan,
      'jumlah_kk': jumlahKk,
      'jumlah_balita': jumlahBalita,
      'jumlah_pus': jumlahPus,
      'jumlah_wus': jumlahWus,
      'jumlah_buta': jumlahButa,
      'jumlah_ibu_hamil': jumlahIbuHamil,
      'jumlah_ibu_menyusui': jumlahIbuMenyusui,
      'jumlah_lansia': jumlahLansia,
      'kriteria_lansia': kriteriaLansia,
      'makanan_pokok': makananPokok,
      'jamban_keluarga': jambanKeluarga,
      'jumlah_jamban_orang': jumlahJambanOrang,
      'sumber_air': sumberAir,
      'tempat_sampah': tempatSampah,
      'saluran_air_limbah': saluranAirLimbah,
      'stiker_p4k': stikerP4k,
      'kriteria_rumah': kriteriaRumah,
      'aktivitas_up2k': aktivitasUp2k,
      'jenis_usaha_up2k': jenisUsahaUp2k,
      'aktivitas_kesehatan_lingkungan': aktivitasKesehatanLingkungan,
    };

    // PENTING: Jangan include 'id' saat insert baru
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
