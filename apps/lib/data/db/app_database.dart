import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) {
      await _ensureWargaSchema(_db!);
      await _ensureKeluargaSchema(_db!);
      await _ensureCatatanSchema(_db!);
      return _db!;
    }
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'mypandak.db');
    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE warga (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            mawar TEXT,
            nik TEXT,
            namaKepala TEXT,
            noRegistrasi TEXT,
            jabatan TEXT,
            jenisKelamin TEXT,
            tempatLahir TEXT,
            tanggalLahir TEXT,
            bulanLahir TEXT,
            tahunLahir TEXT,
            umur TEXT,
            desaKel TEXT,
            kabKota TEXT,
            alamat TEXT,
            statusPerkawinan TEXT,
            statusDalamKeluarga TEXT,
            agama TEXT,
            statusTinggal TEXT,
            pendidikan TEXT,
            pekerjaan TEXT,
            akseptorKb TEXT,
            jenisAkseptorKb TEXT,
            aktifPosyandu TEXT,
            frekuensiPosyandu TEXT,
            binaBalita TEXT,
            memilikiTabungan TEXT,
            paketTabungan TEXT,
            ikutPaud TEXT,
            ikutKoperasi TEXT,
            berkebutuhanKhusus TEXT
          )
        ''');
        await db.execute('CREATE TABLE keluarga (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, mawar TEXT, jumlah TEXT)');
        await db.execute('CREATE TABLE catatan (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, mawar TEXT, tahun TEXT)');
      },
      onOpen: (db) async {
        await _ensureWargaSchema(db);
        await _ensureKeluargaSchema(db);
        await _ensureCatatanSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
        }
      },
    );
    await _ensureWargaSchema(_db!);
    await _ensureKeluargaSchema(_db!);
    await _ensureCatatanSchema(_db!);
    return _db!;
  }

  static Future<void> _ensureCatatanSchema(Database db) async {
    final info = await db.rawQuery('PRAGMA table_info(catatan)');
    final have = info.map((e) => (e['name'] ?? '') as String).toSet();
    final Map<String, String> needed = {
      'kriteriaRumah': 'TEXT',
      'jambanKeluarga': 'TEXT',
      'jumlahJambanOrang': 'TEXT',
      'kesehatan': 'TEXT',
      'anggotaKeluarga': 'TEXT',
    };
    for (final entry in needed.entries) {
      if (!have.contains(entry.key)) {
        try {
          await db.execute('ALTER TABLE catatan ADD COLUMN ${entry.key} ${entry.value}');
        } catch (_) {}
      }
    }
  }

  static Future<void> _ensureWargaSchema(Database db) async {
    final info = await db.rawQuery('PRAGMA table_info(warga)');
    final have = info.map((e) => (e['name'] ?? '') as String).toSet();
    final Map<String, String> needed = {
      'namaKepala': 'TEXT',
      'noRegistrasi': 'TEXT',
      'jabatan': 'TEXT',
      'jenisKelamin': 'TEXT',
      'tempatLahir': 'TEXT',
      'tanggalLahir': 'TEXT',
      'bulanLahir': 'TEXT',
      'tahunLahir': 'TEXT',
      'umur': 'TEXT',
      'desaKel': 'TEXT',
      'kabKota': 'TEXT',
      'alamat': 'TEXT',
      'statusPerkawinan': 'TEXT',
      'statusDalamKeluarga': 'TEXT',
      'agama': 'TEXT',
      'statusTinggal': 'TEXT',
      'pendidikan': 'TEXT',
      'pekerjaan': 'TEXT',
      'akseptorKb': 'TEXT',
      'jenisAkseptorKb': 'TEXT',
      'aktifPosyandu': 'TEXT',
      'frekuensiPosyandu': 'TEXT',
      'binaBalita': 'TEXT',
      'memilikiTabungan': 'TEXT',
      'paketTabungan': 'TEXT',
      'ikutPaud': 'TEXT',
      'ikutKoperasi': 'TEXT',
      'berkebutuhanKhusus': 'TEXT',
    };
    for (final entry in needed.entries) {
      if (!have.contains(entry.key)) {
        try {
          await db.execute('ALTER TABLE warga ADD COLUMN ${entry.key} ${entry.value}');
        } catch (_) {}
      }
    }
  }

  static Future<void> _ensureKeluargaSchema(Database db) async {
    final info = await db.rawQuery('PRAGMA table_info(keluarga)');
    final have = info.map((e) => (e['name'] ?? '') as String).toSet();
    final Map<String, String> needed = {
      'rt': 'TEXT',
      'rw': 'TEXT',
      'dusun': 'TEXT',
      'lingkungan': 'TEXT',
      'jumlahLaki': 'TEXT',
      'jumlahPerempuan': 'TEXT',
      'jumlahKk': 'TEXT',
      'balita': 'TEXT',
      'pus': 'TEXT',
      'wus': 'TEXT',
      'buta': 'TEXT',
      'ibuHamil': 'TEXT',
      'ibuMenyusui': 'TEXT',
      'lansia': 'TEXT',
      'lansiaKriteria': 'TEXT',
      'makananPokok': 'TEXT',
      'jambanKeluarga': 'TEXT',
      'jumlahJamban': 'TEXT',
      'sumberAir': 'TEXT',
      'tempatSampah': 'TEXT',
      'saluranAirLimbah': 'TEXT',
      'stikerP4k': 'TEXT',
      'kriteriaRumah': 'TEXT',
      'aktivitasUp2k': 'TEXT',
      'jenisUsaha': 'TEXT',
      'aktivitasKesehatan': 'TEXT',
      'namaKrtPerkarangan': 'TEXT',
      'namaKrtIndustri': 'TEXT',
      'berkebutuhanKhusus': 'TEXT',
      'pemanfaatanTanah': 'TEXT',
      'industriKeluarga': 'TEXT',
      'anggotaKeluarga': 'TEXT',
    };
    for (final entry in needed.entries) {
      if (!have.contains(entry.key)) {
        try {
          await db.execute('ALTER TABLE keluarga ADD COLUMN ${entry.key} ${entry.value}');
        } catch (_) {}
      }
    }
  }
}
