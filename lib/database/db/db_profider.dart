import 'dart:io';

import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:tes_simetris/model/pesan.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    //jika databes ada , maka mengembalikan database
    if (_database != null) {
      return _database;
    } else {
      //jika database tidak ada , maka membuat database
      _database = await initDB();
      return _database;
    }
  }

  //membuat database pesan
  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    final path = join(documentsDirectory.path, 'ppesan_manager.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ppesan('
          'id_message TEXT PRIMARY KEY,'
          'id_sk TEXT, '
          'title TEXT, '
          'content TEXT, '
          'author TEXT, '
          'level TEXT, '
          'waktu TEXT, '
          'tanggal TEXT, '
          'isRead INT'
          ')');
    });
  }

  //insert pesan on database
  createPesan(Pesan newPesan) async {
    // await deleteAllPesan();
    final db = await database;
    final res = await db.insert('ppesan', newPesan.toJson());

    return res;
  }

  //delete all pesan
  Future<int> deleteAllPesan() async {
    final db = await database;
    print("before : $db");
    final res = db.rawDelete('DELETE FROM ppesan');
    // final res = await db.rawDelete('DELETE * FROM Pesann');
    print("after : $db");
    return res;
  }

  //select pesan
  Future<List<Pesan>> getAllPesan() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM ppesan');

    List<Pesan> list =
        res.isNotEmpty ? res.map((e) => Pesan.fromJson(e)).toList() : [];

    return list;
  }

  Future isRead(int isread, String id) async {
    final db = await database;
    final res = await db.rawUpdate(
        'UPDATE ppesan SET isRead = ' '$isread' ' WHERE id_message = $id');

    print(res);
  }
}
