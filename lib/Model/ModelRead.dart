class Read {
  int id;
  String name;
  String lastRead;

  Read({required this.id, required this.name, required this.lastRead});

  factory Read.fromMap(Map<String, dynamic> data) =>
      Read(id: data['id'], name: data['name'], lastRead: data['lastRead']);

  Map<String, dynamic> toMap(Read product) =>
      {"id": id, "name": name, "lastRead": lastRead};
}
