import 'package:flutter/material.dart';
import 'package:flutter_quran/Akun.dart';
import 'package:flutter_quran/Baca.dart';
import 'package:flutter_quran/Riwayat.dart';
import 'package:flutter_quran/BuatAkun.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  late String id;

  @override
  State<MyHomePage> createState() => SeecondMyHomePage();
}

class SeecondMyHomePage extends State<MyHomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("AL-QURAN"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
          child: _getBody(),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Baca',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2),
                label: 'Akun',
              ),
            ]));
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return Baca();
      case 1:
        return AccountScreen();
      default:
        return AkunProfil();
    }
  }
}
