import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_quran/Model/ModelAPI.dart';
import 'package:http/http.dart' as http;

class QuranController extends GetxController {
  var isLoading = false.obs;
  final String url = 'http://192.168.90.194:4000';
  List<Quran> product = <Quran>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getQuran();
  }

  getQuran() async {
    isLoading(true);
    final response = await http.get(Uri.parse('$url/surah'));
    isLoading.value = false;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['data']);

      product = List<Quran>.from(data['data'].map((x) => Quran.fromMap(x)));
    }
    isLoading(false);
  }
}
