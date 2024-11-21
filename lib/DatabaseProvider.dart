//provider
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  late Database _database;

  Future<Database> get database async {
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "localapp.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      db.execute("""CREATE TABLE Contact (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT
      )""");
      db.execute("""CREATE TABLE Akun (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        password TEXT
      )""");
    });
  }
}
