import 'package:flutter_quran/Model/ModelAkun.dart';
import 'package:flutter_quran/DatabaseProvider.dart';
import 'package:sqflite/sqflite.dart';

class AkunDataAccess {
  Future<List<Akun>> getAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Akun");
    List<Akun> list = response.map((e) => Akun.fromMap(e)).toList();
    return list;
  }

  Future<Akun?> getByID(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Akun", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Akun.fromMap(response.first) : null;
  }

  Future<Akun?> getByIDAndPassword(int id, String password) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Akun",
        where: "id = ? AND password = ?", whereArgs: [id, password]);
    return response.isNotEmpty ? Akun.fromMap(response.first) : null;
  }

  insert(Akun akun) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.insert(
        "Akun", {"id": akun.id, "nama": akun.nama, "password": akun.password},
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response;
  }

  update(Akun akun) async {
    final db = await DatabaseProvider.db.database;
    var response = await db
        .update("Akun", akun.toMap(), where: "id = ?", whereArgs: [akun.id]);
    return response;
  }

  delete(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Akun", where: "id = ?", whereArgs: [id]);
    return response;
  }

  deleteAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Akun");
    return response;
  }
}
