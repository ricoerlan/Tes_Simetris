import 'dart:convert';

List<Pesan> employeeFromJson(String str) =>
    List<Pesan>.from(json.decode(str).map((x) => Pesan.fromJson(x)));

String employeeToJson(List<Pesan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => jsonEncode(x))));

class Pesan {
  String id_message;
  String id_sk;
  String title;
  String content;
  String author;
  String level;
  String waktu;
  String tanggal;

  Pesan(
      {this.id_message,
      this.id_sk,
      this.title,
      this.content,
      this.author,
      this.level,
      this.waktu,
      this.tanggal});

  factory Pesan.fromJson(Map<String, dynamic> json) {
    return Pesan(
      id_message: json["id_message"],
      id_sk: json["id_sk"],
      title: json["title"],
      content: json["content"],
      author: json["author"],
      level: json["level"],
      waktu: json["waktu"],
      tanggal: json["tanggal"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_message": id_message,
        "id_sk": id_sk,
        "title": title,
        "content": content,
        "author": author,
        "level": level,
        "waktu": waktu,
        "tanggal": tanggal
      };
}
