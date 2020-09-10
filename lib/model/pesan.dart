class Pesan{
  String id ;
  String id_sk;
  String title;
  String content;
  String author;
  String level;
  String waktu;
  String tanggal;
  


  Pesan(
    {this.id, this.id_sk, this.title, this.content, this.author, this.level, this.waktu, this.tanggal}
  );

  factory Pesan.fromJson(Map<String, dynamic> json) {
    return Pesan (
      id : json["id_mesaage"],
      id_sk : json["id_sk"],
      title : json["title"],
      content: json ["content"],
      author: json ["author"],
      level : json["level"],
      waktu: json["waktu"],
      tanggal : json["tanggal"],
      
      );

  }

}