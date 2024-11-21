// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_quran/Database/sql_model.dart';
import 'package:flutter_quran/Database/contact_dataaccess.dart';
import 'package:get/get.dart';

class ContactDetail extends StatelessWidget {
  ContactDetail({super.key});
  ContactDataAccess dataAccess = ContactDataAccess();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    "id": 0,
    "name": "",
    "phone": "",
    "email": ""
  };

  void onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(formData);
      await dataAccess.insert(Contact.fromMap(formData));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Baca'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Al-Quranul Karim'),
                        keyboardType: TextInputType.number,
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Nama Surah'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input a name surah";
                          }
                        },
                        onSaved: (newvalue) {
                          formData["name"] = newvalue;
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ayat ke  '),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input a ayat";
                          }
                        },
                        onSaved: (newvalue) {
                          formData["phone"] = newvalue;
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Juz ke - '),
                        keyboardType: TextInputType.phone,
                        onSaved: (newvalue) {
                          formData["email"] = newvalue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey),
                          onPressed: onSave,
                          child: Text('Bayar')),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
