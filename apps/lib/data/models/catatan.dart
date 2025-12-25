class Catatan {
  final int? id;
  final String nama;
  final String mawar;
  final String tahun;
  final String? kriteriaRumah;
  final String? jambanKeluarga;
  final String? jumlahJambanOrang;
  final String? kesehatan;
  final String? anggotaKeluarga;

  Catatan({
    this.id,
    required this.nama,
    required this.mawar,
    required this.tahun,
    this.kriteriaRumah,
    this.jambanKeluarga,
    this.jumlahJambanOrang,
    this.kesehatan,
    this.anggotaKeluarga,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nama': nama,
    'mawar': mawar,
    'tahun': tahun,
    'kriteriaRumah': kriteriaRumah,
    'jambanKeluarga': jambanKeluarga,
    'jumlahJambanOrang': jumlahJambanOrang,
    'kesehatan': kesehatan,
    'anggotaKeluarga': anggotaKeluarga,
  };

  static Catatan fromMap(Map<String, dynamic> m) => Catatan(
    id: m['id'] as int?,
    nama: m['nama'] as String,
    mawar: m['mawar'] as String,
    tahun: m['tahun'] as String,
    kriteriaRumah: m['kriteriaRumah'] as String?,
    jambanKeluarga: m['jambanKeluarga'] as String?,
    jumlahJambanOrang: m['jumlahJambanOrang'] as String?,
    kesehatan: m['kesehatan'] as String?,
    anggotaKeluarga: m['anggotaKeluarga'] as String?,
  );
}
