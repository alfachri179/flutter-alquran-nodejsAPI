import 'package:flutter/material.dart';
import 'package:flutter_quran/Controller/ControllerAPI.dart';
import 'package:flutter_quran/Controller/ControllerSurah.dart';
import 'package:flutter_quran/ModelSurah.dart';
import 'package:flutter_quran/detailSurah.dart';
import 'package:get/get.dart';

class DetailSurah extends StatelessWidget {
  DetailSurah({required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControllerSurah(id));

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Surah"),
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.product.length,
              itemBuilder: (context, index) {
                final product = controller.product[index];
                return GestureDetector(
                  onTap: () {
                    _showConfirmationDialog(context, product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.1)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(7),
                      title: Text(
                        product.ar,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textDirection: TextDirection.rtl,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Text(product.id),
                        ],
                      ),
                      onTap: () {
                        // Tambahkan logika atau navigasi sesuai kebutuhan saat ListTile diklik
                        _showConfirmationDialog(context, product);
                      },
                    ),
                  ),
                );
              },
            )),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showConfirmationDialog(BuildContext context, Surah product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Simpan ke terakhir dibaca?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika penyimpanan data di sini
                // Misalnya: saveData(product);
                Navigator.of(context).pop();
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}
