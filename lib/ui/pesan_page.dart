import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/ui/detail_pesan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/pesan.dart';

class ListPage extends StatefulWidget {
  final String title;

  ListPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String iconUrl;
  String id_sk;

  // void getId(String id_sk){
  //   this.id_sk = id_sk;
  // }

  Future<List<Pesan>> getData() async {
    List<Pesan> list;

    String link = "http://jogjamotor24jam.com/getAllMessages.php?id_sk=$id_sk";

    var res = await http.get(Uri.encodeFull(link));
    print(res.body);

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      print(rest);

      list = rest.map<Pesan>((json) => Pesan.fromJson(json)).toList();
    }

    print("List Size: ${list.length}");
    return list;
  }

  AssetImage getImage(String author) {
    if (author == 'Humas') {
      return AssetImage("assets/065-manager.png");
    } else if (author == 'INSTI') {
      return AssetImage("assets/030-mechanic.png");
    } else if (author == 'Poliklinik') {
      return AssetImage("assets/060-nurse.png");
    } else {
      return AssetImage("assets/039-marketing.png");
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var email;
  var nama;
  // var id_sk;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // email = preferences.getString("email");
      // nama = preferences.getString("nama");
      id_sk = preferences.getString("id_sk");
    });
    print("id_sk pref :  $id_sk");
    // print("email : $email");
  }

  @override
  Widget build(BuildContext context) {
    void _onTapItem(BuildContext context, Pesan pesan, String author) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DetailPage(
                pesan: pesan,
                author: author,
              )));

      print(author);
    }

    Widget listViewWidget(List<Pesan> pesan) {
      return Container(
        child: ListView.builder(
            itemCount: pesan.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, position) {
              return Card(
                elevation: 2.0,
                child: Container(
                  height: 100.0,
                  width: 120.0,
                  child: Center(
                    child: ListTile(
                      //Header
                      leading: Container(
                          child: Column(
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage:
                                  getImage('${pesan[position].author}')),
                          Text(
                            '${pesan[position].author}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),

                      title: Text(
                        '${pesan[position].title}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(
                        '${pesan[position].content}',
                        maxLines: 2,
                      ),

                      // Footer
                      trailing: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${pesan[position].tanggal}',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text('${pesan[position].waktu}',
                                style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      onTap: () => _onTapItem(context, pesan[position],
                          '${pesan[position].author}'),
                    ),
                  ),
                ),
              );
            }),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? listViewWidget(snapshot.data)
              : Center(
                  child: SpinKitPouringHourglass(
                  color: Colors.blue,
                  size: 100,
                ));
        },
      ),
      //body: makeBody,
    );
  }
}
