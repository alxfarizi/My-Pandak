import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/catatan.dart';

class CatatanRepository {
  Future<List<Catatan>> getAll() async {
    final db = await AppDatabase.instance;
    final rows = await db.query('catatan', orderBy: 'id DESC');
    return rows.map((e) => Catatan.fromMap(e)).toList();
  }

  Future<int> insert(Catatan c) async {
    final db = await AppDatabase.instance;
    return db.insert('catatan', c.toMap());
  }

  Future<int> update(Catatan c) async {
    final db = await AppDatabase.instance;
    return db.update('catatan', c.toMap(), where: 'id = ?', whereArgs: [c.id]);
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance;
    return db.delete('catatan', where: 'id = ?', whereArgs: [id]);
  }
}
