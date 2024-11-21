import 'package:flutter/material.dart';
import 'package:flutter_quran/Controller/ControllerAPI.dart';
import 'package:flutter_quran/detailSurah.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class Baca extends StatelessWidget {
  Baca({super.key});
  final controller = Get.put(QuranController());
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // You can adjust the number of columns as needed
                  crossAxisSpacing: 4.0, // Adjust the spacing between columns
                  mainAxisSpacing: 4.0, // Adjust the spacing between rows
                  mainAxisExtent: 180),
              itemCount: controller.product.length,
              itemBuilder: (context, index) {
                final product = controller.product[index];
                String url = "https://mushaf.id/sources/media/alafasy/full/" +
                    product.nomor +
                    ".mp3";
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.1),
                  ),
                  child: ListTile(
                    title: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(product.nama),
                        Text(product.arti),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await player.play(UrlSource(url));
                              },
                              icon: Icon(Icons.play_arrow_rounded),
                            ),
                            IconButton(
                              onPressed: () async {
                                await player.stop();
                              },
                              icon: Icon(Icons.stop_circle_rounded),
                            ),
                            Icon(Icons.book),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.to(DetailSurah(id: product.nomor));
                      // Tambahkan logika atau navigasi sesuai kebutuhan saat ListTile diklik
                    },
                  ),
                );
              },
            )),
    );
    ;
  }
}
