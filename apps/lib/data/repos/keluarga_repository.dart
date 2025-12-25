import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/keluarga.dart';

class KeluargaRepository {
  Future<List<Keluarga>> getAll() async {
    final db = await AppDatabase.instance;
    final rows = await db.query('keluarga', orderBy: 'id DESC');
    return rows.map((e) => Keluarga.fromMap(e)).toList();
  }

  Future<int> insert(Keluarga k) async {
    final db = await AppDatabase.instance;
    return db.insert('keluarga', k.toMap());
  }

  Future<int> update(Keluarga k) async {
    final db = await AppDatabase.instance;
    return db.update(
      'keluarga',
      k.toMap(),
      where: 'id = ?',
      whereArgs: [k.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance;
    return db.delete(
      'keluarga',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
