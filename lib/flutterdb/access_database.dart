
import 'dart:io';

import 'package:sqflite/sqflite.dart';

class AccessDatabase {

  void _creatDB(Database db, int version) async{
    await db.execute(''' 
    CREATE TABLE pesan (
      id TEXT PRIMARY KEY,
      id_sk TEXT,
      title TEXT,
      content TEXT,
      level TEXT,
      author TEXT,
      waktu TEXT,
      tanggal TEXT    
    )
    ''');
  }

  


}