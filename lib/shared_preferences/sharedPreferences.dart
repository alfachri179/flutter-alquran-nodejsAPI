import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String KEY_USER_ID = 'user_id';

  // Simpan ID pengguna ke shared preferences
  static Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_ID, userId);
  }

  // Dapatkan ID pengguna dari shared preferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_ID);
  }

  // Hapus ID pengguna dari shared preferences
  static Future<void> deleteUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY_USER_ID);
  }

  static Future<void> clearShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
