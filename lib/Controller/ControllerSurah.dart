import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_quran/ModelSurah.dart';
import 'package:http/http.dart' as http;

class ControllerSurah extends GetxController {
  ControllerSurah(this.id);
  final String id;
  var isLoading = false.obs;
  final String url = 'http://192.168.90.194:4000';
  List<Surah> product = <Surah>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getSurah();
  }

  getSurah() async {
    isLoading(true);
    final response = await http.get(Uri.parse('$url/surah/$id'));
    isLoading.value = false;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['data']);

      product = List<Surah>.from(data['data'].map((x) => Surah.fromMap(x)));
    }
    isLoading(false);
  }
}
