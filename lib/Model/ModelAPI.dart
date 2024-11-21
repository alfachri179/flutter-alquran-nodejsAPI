class Quran {
  String arti;
  String asma;
  int ayat;
  String nama;
  String type;
  String urut;
  String audio;
  String nomor;
  String rukuk;
  String keterangan;

  Quran(
      {required this.arti,
      required this.asma,
      required this.ayat,
      required this.nama,
      required this.type,
      required this.urut,
      required this.audio,
      required this.nomor,
      required this.rukuk,
      required this.keterangan});

  factory Quran.fromMap(Map<String, dynamic> data) => Quran(
      arti: data['arti'],
      asma: data['asma'],
      ayat: data['ayat'],
      nama: data['nama'],
      type: data['type'],
      urut: data['urut'],
      audio: data['audio'],
      nomor: data['nomor'],
      rukuk: data['rukuk'],
      keterangan: data['keterangan']);

  Map<String, dynamic> toMap(Quran product) => {
        "arti": arti,
        "asma": asma,
        "ayat": ayat,
        "type": type,
        "urut": urut,
        "audio": audio,
        "nomor": nomor,
        "rukuk": keterangan,
        "keterangan": keterangan
      };
}
