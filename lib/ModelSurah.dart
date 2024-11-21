class Surah {
  String ar;
  String id;
  String tr;
  String nomor;

  Surah(
      {required this.ar,
      required this.id,
      required this.tr,
      required this.nomor});

  factory Surah.fromMap(Map<String, dynamic> data) => Surah(
        ar: data['ar'],
        id: data['id'],
        tr: data['tr'],
        nomor: data['nomor'],
      );

  Map<String, dynamic> toMap(Surah product) => {
        "ar": ar,
        "id": id,
        "tr": tr,
        "nomor": nomor,
      };
}
