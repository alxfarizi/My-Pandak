class Keluarga {
  final int? id;
  final String nama; 
  final String mawar; 
  final String jumlah; 

  final String? rt;
  final String? rw;
  final String? dusun;
  final String? lingkungan;
  final String? jumlahLaki;
  final String? jumlahPerempuan;
  final String? jumlahKk;
  final String? balita;
  final String? pus;
  final String? wus;
  final String? buta;
  final String? ibuHamil;
  final String? ibuMenyusui;
  final String? lansia;
  final String? lansiaKriteria;
  final String? makananPokok;
  final String? jambanKeluarga;
  final String? jumlahJamban;
  final String? sumberAir;
  final String? tempatSampah;
  final String? saluranAirLimbah;
  final String? stikerP4k;
  final String? kriteriaRumah;
  final String? aktivitasUp2k;
  final String? jenisUsaha;
  final String? aktivitasKesehatan;
  final String? namaKrtPerkarangan;
  final String? namaKrtIndustri;
  final String? berkebutuhanKhusus;
  final String? pemanfaatanTanah;
  final String? industriKeluarga; 
  final String? anggotaKeluarga; 

  Keluarga({
    this.id,
    required this.nama,
    required this.mawar,
    required this.jumlah,
    this.rt,
    this.rw,
    this.dusun,
    this.lingkungan,
    this.jumlahLaki,
    this.jumlahPerempuan,
    this.jumlahKk,
    this.balita,
    this.pus,
    this.wus,
    this.buta,
    this.ibuHamil,
    this.ibuMenyusui,
    this.lansia,
    this.lansiaKriteria,
    this.makananPokok,
    this.jambanKeluarga,
    this.jumlahJamban,
    this.sumberAir,
    this.tempatSampah,
    this.saluranAirLimbah,
    this.stikerP4k,
    this.kriteriaRumah,
    this.aktivitasUp2k,
    this.jenisUsaha,
    this.aktivitasKesehatan,
    this.namaKrtPerkarangan,
    this.namaKrtIndustri,
    this.berkebutuhanKhusus,
    this.pemanfaatanTanah,
    this.industriKeluarga,
    this.anggotaKeluarga,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'mawar': mawar,
        'jumlah': jumlah,
        'rt': rt,
        'rw': rw,
        'dusun': dusun,
        'lingkungan': lingkungan,
        'jumlahLaki': jumlahLaki,
        'jumlahPerempuan': jumlahPerempuan,
        'jumlahKk': jumlahKk,
        'balita': balita,
        'pus': pus,
        'wus': wus,
        'buta': buta,
        'ibuHamil': ibuHamil,
        'ibuMenyusui': ibuMenyusui,
        'lansia': lansia,
        'lansiaKriteria': lansiaKriteria,
        'makananPokok': makananPokok,
        'jambanKeluarga': jambanKeluarga,
        'jumlahJamban': jumlahJamban,
        'sumberAir': sumberAir,
        'tempatSampah': tempatSampah,
        'saluranAirLimbah': saluranAirLimbah,
        'stikerP4k': stikerP4k,
        'kriteriaRumah': kriteriaRumah,
        'aktivitasUp2k': aktivitasUp2k,
        'jenisUsaha': jenisUsaha,
        'aktivitasKesehatan': aktivitasKesehatan,
        'namaKrtPerkarangan': namaKrtPerkarangan,
        'namaKrtIndustri': namaKrtIndustri,
        'berkebutuhanKhusus': berkebutuhanKhusus,
        'pemanfaatanTanah': pemanfaatanTanah,
        'industriKeluarga': industriKeluarga,
        'anggotaKeluarga': anggotaKeluarga,
      };

  static Keluarga fromMap(Map<String, dynamic> m) => Keluarga(
        id: m['id'] as int?,
        nama: (m['nama'] ?? '') as String,
        mawar: (m['mawar'] ?? '') as String,
        jumlah: (m['jumlah'] ?? '') as String,
        rt: m['rt'] as String?,
        rw: m['rw'] as String?,
        dusun: m['dusun'] as String?,
        lingkungan: m['lingkungan'] as String?,
        jumlahLaki: m['jumlahLaki'] as String?,
        jumlahPerempuan: m['jumlahPerempuan'] as String?,
        jumlahKk: m['jumlahKk'] as String?,
        balita: m['balita'] as String?,
        pus: m['pus'] as String?,
        wus: m['wus'] as String?,
        buta: m['buta'] as String?,
        ibuHamil: m['ibuHamil'] as String?,
        ibuMenyusui: m['ibuMenyusui'] as String?,
        lansia: m['lansia'] as String?,
        lansiaKriteria: m['lansiaKriteria'] as String?,
        makananPokok: m['makananPokok'] as String?,
        jambanKeluarga: m['jambanKeluarga'] as String?,
        jumlahJamban: m['jumlahJamban'] as String?,
        sumberAir: m['sumberAir'] as String?,
        tempatSampah: m['tempatSampah'] as String?,
        saluranAirLimbah: m['saluranAirLimbah'] as String?,
        stikerP4k: m['stikerP4k'] as String?,
        kriteriaRumah: m['kriteriaRumah'] as String?,
        aktivitasUp2k: m['aktivitasUp2k'] as String?,
        jenisUsaha: m['jenisUsaha'] as String?,
        aktivitasKesehatan: m['aktivitasKesehatan'] as String?,
        namaKrtPerkarangan: m['namaKrtPerkarangan'] as String?,
        namaKrtIndustri: m['namaKrtIndustri'] as String?,
        berkebutuhanKhusus: m['berkebutuhanKhusus'] as String?,
        pemanfaatanTanah: m['pemanfaatanTanah'] as String?,
        industriKeluarga: m['industriKeluarga'] as String?,
        anggotaKeluarga: m['anggotaKeluarga'] as String?,
      );
}
