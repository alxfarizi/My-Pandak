//catatan_keluarga.dart - ENHANCED WITH COPYWITH
class CatatanKeluarga {
  final int? id;
  final int keluargaId;
  final int tahun;
  final String? namaPencatat;
  final String? anggotaKelompokDasaWisma;
  final String? kriteriaRumah;
  final bool jambanKeluarga;
  final int jumlahJambanOrang;
  final bool tempatSampah;
  final String? statusKesehatan;
  final DateTime? tanggalPencatatan;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CatatanKeluarga({
    this.id,
    required this.keluargaId,
    required this.tahun,
    this.namaPencatat,
    this.anggotaKelompokDasaWisma,
    this.kriteriaRumah,
    this.jambanKeluarga = false,
    this.jumlahJambanOrang = 0,
    this.tempatSampah = false,
    this.statusKesehatan,
    this.tanggalPencatatan,
    this.status = 'Draft',
    this.createdAt,
    this.updatedAt,
  });

  // ADDED: copyWith method
  CatatanKeluarga copyWith({
    int? id,
    int? keluargaId,
    int? tahun,
    String? namaPencatat,
    String? anggotaKelompokDasaWisma,
    String? kriteriaRumah,
    bool? jambanKeluarga,
    int? jumlahJambanOrang,
    bool? tempatSampah,
    String? statusKesehatan,
    DateTime? tanggalPencatatan,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CatatanKeluarga(
      id: id ?? this.id,
      keluargaId: keluargaId ?? this.keluargaId,
      tahun: tahun ?? this.tahun,
      namaPencatat: namaPencatat ?? this.namaPencatat,
      anggotaKelompokDasaWisma:
          anggotaKelompokDasaWisma ?? this.anggotaKelompokDasaWisma,
      kriteriaRumah: kriteriaRumah ?? this.kriteriaRumah,
      jambanKeluarga: jambanKeluarga ?? this.jambanKeluarga,
      jumlahJambanOrang: jumlahJambanOrang ?? this.jumlahJambanOrang,
      tempatSampah: tempatSampah ?? this.tempatSampah,
      statusKesehatan: statusKesehatan ?? this.statusKesehatan,
      tanggalPencatatan: tanggalPencatatan ?? this.tanggalPencatatan,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CatatanKeluarga.fromJson(Map<String, dynamic> json) {
    return CatatanKeluarga(
      id: json['id'],
      keluargaId: json['keluarga_id'],
      tahun: json['tahun'],
      namaPencatat: json['nama_pencatat'],
      anggotaKelompokDasaWisma: json['anggota_kelompok_dasa_wisma'],
      kriteriaRumah: json['kriteria_rumah'],
      jambanKeluarga: json['jamban_keluarga'] ?? false,
      jumlahJambanOrang: json['jumlah_jamban_orang'] ?? 0,
      tempatSampah: json['tempat_sampah'] ?? false,
      statusKesehatan: json['status_kesehatan'],
      tanggalPencatatan: json['tanggal_pencatatan'] != null
          ? DateTime.parse(json['tanggal_pencatatan'])
          : null,
      status: json['status'] ?? 'Draft',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'keluarga_id': keluargaId,
      'tahun': tahun,
      'nama_pencatat': namaPencatat,
      'anggota_kelompok_dasa_wisma': anggotaKelompokDasaWisma,
      'kriteria_rumah': kriteriaRumah,
      'jamban_keluarga': jambanKeluarga,
      'jumlah_jamban_orang': jumlahJambanOrang,
      'tempat_sampah': tempatSampah,
      'status_kesehatan': statusKesehatan,
      'tanggal_pencatatan': tanggalPencatatan?.toIso8601String().split('T')[0],
      'status': status,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
