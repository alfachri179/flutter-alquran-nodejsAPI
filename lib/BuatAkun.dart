import 'package:flutter/material.dart';
import 'package:flutter_quran/DatabaseHelper.dart';
import 'package:flutter_quran/HomePage.dart';
import 'package:flutter_quran/Model/ModelAkun.dart';
import 'package:flutter_quran/main.dart';
import 'package:get/get.dart ';
import 'dart:math';
import 'package:flutter_quran/shared_preferences/sharedPreferences.dart';

class BuatAkun extends StatelessWidget {
  BuatAkun({super.key});
  AkunDataAccess datahelper = AkunDataAccess();

  int generateRandomNumber() {
    final random = Random();
    return 0 + random.nextInt(9999999 - 0 + 1);
  }

  final _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> formdata = {"id": 0, "nama": "", "password": ""};

  void onSave() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      print(formdata);
      await datahelper.insert(Akun.fromMap(formdata));
      Get.to(MyHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // Ganti warna AppBar sesuai keinginan Anda
          backgroundColor: Colors.lightGreen,
          title: const Text("Regis Akun"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    "BUAT AKUN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person), labelText: "Masukan Nama"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Input Name";
                      }
                    },
                    onSaved: (newValue) {
                      formdata['nama'] = newValue;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Masukan Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please insert password";
                      }
                    },
                    onSaved: (newValue) {
                      formdata['password'] = newValue;
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          formdata['id'] = generateRandomNumber();
                          SessionManager.saveUserId(formdata['id'].toString());
                          onSave();
                        },
                        child: const Text('SUBMIT'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
