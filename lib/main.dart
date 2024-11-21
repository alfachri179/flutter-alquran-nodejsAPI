import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quran/BuatAkun.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quran/HomePage.dart';
import 'package:flutter_quran/DatabaseHelper.dart'; // Import your AkunDataAccess class
import 'package:flutter_quran/Model/ModelAkun.dart';
import 'package:flutter_quran/shared_preferences/sharedPreferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var imagePath = ''.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AkunDataAccess akunDataAccess =
      AkunDataAccess(); // Instantiate your AkunDataAccess class

  openCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    imagePath(pickedImage == null ? '' : pickedImage.path);
  }

  Future<bool> checkAccountExistence(String username, String password) async {
    // Use your AkunDataAccess class to check account existence in SQLite
    List<Akun> akunList = await akunDataAccess.getAll();

    for (Akun akun in akunList) {
      if (akun.nama == username && akun.password == password) {
        return true; // Account exists
      }
    }

    return false; // Account doesn't exist
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text("Al Qur'an"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: imagePath.value == ''
                      ? Image.asset('assets/images/fotoContoh.png')
                      : Image.file(File(imagePath.value)),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    await openCamera();
                  },
                  child: const Text("ubah foto"),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Masukan Nama",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Masukan Password',
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      String username = usernameController.text;
                      String password = passwordController.text;

                      // Check the existence of the account in SQLite
                      bool accountExists =
                          await checkAccountExistence(username, password);

                      if (accountExists) {
                        //set sesi
                        SessionManager.clearShared();
                        SessionManager.saveUserId(username.toString());
                        // Account exists, navigate to BuatAkun
                        Get.to(MyHomePage());
                      } else {
                        // Account doesn't exist, show a Snackbar
                        Get.snackbar(
                          'Login Failed',
                          'Invalid username or password',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: const Text('SUBMIT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: const Text(
                        "Buat Akun",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      onTap: () {
                        Get.to(BuatAkun());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
