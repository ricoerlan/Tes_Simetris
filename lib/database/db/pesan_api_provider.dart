
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http ;

import 'package:tes_simetris/database/db/db_profider.dart';
import 'package:tes_simetris/model/pesan.dart';

class PesanApiProvider {

  String id_sk = "2";

  Future<List<Pesan>> getAllPesan() async {
    var url = "http://jogjamotor24jam.com/getAllMessages.php?id_sk=$id_sk";
    var res = await http.get(Uri.encodeFull(url));
    print(res.body);

    var data = json.decode(res.body);
    var rest = data as List;


    return (rest as List).map((pesan) {
      print('Inserting $rest');
      var tes = DBProvider.db.createPesan(Pesan.fromJson(pesan));
      print('tess : $tes');
    }).toList();
  }
}