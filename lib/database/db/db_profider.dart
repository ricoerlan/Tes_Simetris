import 'dart:io';


import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:tes_simetris/model/pesan.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();


  DBProvider._ ();

  Future<Database> get database async{
    //jika databes ada , maka mengembalikan database 
    if (_database != null ) return _database;

    //jika database tidak ada , maka membuat database 
    _database = await initDB();

    return _database;
  }


  //inital database pesan

  initDB() async{

    Directory documentsDirectory = await getApplicationSupportDirectory();
    final path = join(documentsDirectory.path, 'pesan_manager.db');

    return await openDatabase(path, version : 1 , onOpen : (db) {},
    onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE pesann('
        'id_message TEXT PRIMARY KEY,'
        'id_sk TEXT, '
        'title TEXT, '
        'content TEXT, '
        'author TEXT, '
        'level TEXT, '
        'waktu TEXT, '
        'tanggal TEXT '

      ')');
    });
  }

  //insert pesan on database 
  createPesan(Pesan newPesan) async{
    await deleteAllPesan();
    final db = await database;
    final res = await db.insert('Pesann', newPesan.toJson());

    return res;
  }

  //delete all pesan
  Future<int> deleteAllPesan() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Pesann');

    return res; 
  }

  Future<List<Pesan>> getAllPesan()async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM Pesann');

    List<Pesan> list = 
    res.isNotEmpty ? res.map((e) => Pesan.fromJson(e)).toList() : [];

    return list;
  }

 

}