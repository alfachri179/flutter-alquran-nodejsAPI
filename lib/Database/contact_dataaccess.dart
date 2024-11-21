// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_quran/Database/sql_model.dart';
import 'package:flutter_quran/Database/sql_provider.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ContactDataAccess {
  Future<List<Contact>> getAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Contact");
    List<Contact> list = response.map((e) => Contact.fromMap(e)).toList();
    return list;
  }

  Future<Contact?> getByID(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Contact", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Contact.fromMap(response.first) : null;
  }

  insert(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.insert("Contact",
        {"name": contact.name, "phone": contact.phone, "email": contact.email},
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response;
  }

  update(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.update("Contact", contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
    return response;
  }

  delete(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Contact", where: "id = ?", whereArgs: [id]);
    return response;
  }

  deleteAll(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Contact");
    return response;
  }
}
