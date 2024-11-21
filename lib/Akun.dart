import 'package:flutter/material.dart';
import 'package:flutter_quran/DatabaseHelper.dart';
import 'package:flutter_quran/Model/ModelAkun.dart';
import 'package:flutter_quran/main.dart';
import 'package:flutter_quran/shared_preferences/sharedPreferences.dart';
import 'package:get/get.dart';

class AkunProfil extends StatelessWidget {
  AkunProfil({Key? key}) : super(key: key);

  AkunDataAccess ada = AkunDataAccess();
  late String id;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<Akun?>(
          future: getIdFromSharedPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              Akun akun = snapshot.data!;

              return Container(
                padding: EdgeInsets.all(17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "ID: " + akun.id.toString(),
                      ),
                    ),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Nama: " + akun.nama,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          SessionManager.deleteUserId();
                          Get.back();
                        },
                        child: Text("LOG OUT"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('Tidak ada data ditemukan');
            }
          },
        ),
      ),
    );
  }

  Future<Akun?> getIdFromSharedPreferences() async {
    String? userId = await SessionManager.getUserId();
    if (userId != null) {
      id = userId;
      return ada.getByID(int.parse(id));
    } else {
      throw Exception("UserID is null");
    }
  }
}
