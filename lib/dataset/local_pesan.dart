// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class SqlPesan{

//   String id ;
//   String id_sk;
//   String title;
//   String content;
//   String level;
//   String author;
//   String waktu;
//   String tanggal;


//   SqlPesan({this.id, this.id_sk, this.title, this.content, this.level, this.author, this.tanggal, this.waktu});

//   //convert sqlPesan to a Map
//   Map<String, dynamic> toMap() {
//     return{
//       'id' : id,
//       'id_sk' : id_sk,
//       'title ': title,
//       'content' : content,
//       'level' : level,
//       'author' : author, 
//       'waktu' : waktu,
//       'tanggal' : tanggal
//     };
//   }

  
// }

// Future<void> insertPesan(SqlPesan sqlPesan) async{
//   final Database db = await database;

//   await db.insert(table, values)
// }