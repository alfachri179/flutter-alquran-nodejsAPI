// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, library_private_types_in_public_api, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_quran/Database/contact_dataaccess.dart';
import 'package:flutter_quran/Database/contact_detail.dart';
import 'package:flutter_quran/Database/sql_model.dart';
import 'package:flutter_quran/Database/sql_provider.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Contact> list = <Contact>[].obs;
  ContactDataAccess dataAccess = ContactDataAccess();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var data = await dataAccess.getAll();
    list.clear();
    list.addAll(data);
  }

  onDelete(int id) async {
    bool confirm = await Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Are You Sure'),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: Text('No')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text('Yes')),
            ],
          )
        ],
      ),
    ));

    if (confirm) {
      await dataAccess.delete(id);
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SQLite',
      home: Scaffold(
        body: Obx(
          () => ListView.separated(
            itemCount: list.length,
            separatorBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                height: 1,
                color: Colors.blueGrey),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.book,
                            size: 32,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index].name.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.numbers,
                                    color: Colors.blueGrey,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    list[index].phone.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.numbers_outlined,
                                    color: Colors.blueGrey,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    list[index].email.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        onDelete(list[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await Get.to(ContactDetail());
                getData();
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
