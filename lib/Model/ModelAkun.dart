class Akun {
  int id;
  String nama;
  String password;

  Akun({required this.id, required this.nama, required this.password});

  Map<String, dynamic> toMap() =>
      {"id": id, "nama": nama, "password": password};

  factory Akun.fromMap(Map<String, dynamic> map) =>
      Akun(id: map['id'], nama: map['nama'], password: map['password']);
}
