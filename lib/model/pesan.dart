class Pesan{
  String id ;
  String title;
  String content;
  String level;
  String indicatorValue;
  


  Pesan(
    {this.id, this.title, this.level, this.indicatorValue,this.content}
  );

  factory Pesan.fromJson(Map<String, dynamic> json) {
    return Pesan (
      id : json["id"],
      title : json["title"],
      content: json ["content"],
      level : json["content"],
      indicatorValue: json["indicator"]
      
      );

  }

}