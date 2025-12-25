import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/warga.dart';

class WargaRepository {
  Future<List<Warga>> getAll() async {
    final db = await AppDatabase.instance;
    final rows = await db.query('warga', orderBy: 'id DESC');
    return rows.map((e) => Warga.fromMap(e)).toList();
  }

  Future<int> insert(Warga w) async {
    final db = await AppDatabase.instance;
    return db.insert('warga', w.toMap());
  }

  Future<int> update(Warga w) async {
    if (w.id == null) throw ArgumentError('id required for update');
    final db = await AppDatabase.instance;
    return db.update('warga', w.toMap(), where: 'id = ?', whereArgs: [w.id]);
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance;
    return db.delete('warga', where: 'id = ?', whereArgs: [id]);
  }
}
