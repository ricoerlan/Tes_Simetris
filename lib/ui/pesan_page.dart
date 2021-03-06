import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tes_simetris/database/db/db_profider.dart';
import 'package:tes_simetris/database/db/pesan_api_provider.dart';
import 'package:tes_simetris/services/firebase_notification.dart';
import 'package:tes_simetris/ui/detail_pesan.dart';
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
  int id_sk = 2;

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
  }

  FontWeight isRead(int isRead) {
    if (isRead == 1) {
      return FontWeight.normal;
    } else {
      return FontWeight.bold;
    }
  }

  Icon iconIsRead(int isRead) {
    if (isRead == 1) {
      return Icon(
        Icons.mail,
        color: Colors.grey,
      );
    } else {
      return Icon(
        Icons.mail,
        color: Colors.green,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Firebasess(context: context).initNotifications();
    // getPref();
    _loadFromApi();
  }

  var email;
  var nama;
  // var id_sk;

  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     // email = preferences.getString("email");
  //     // nama = preferences.getString("nama");
  //     id_sk = preferences.getString("id_sk");
  //   });
  //   print("id_sk pref :  $id_sk");

  //   // print("email : $email
  // }

  _loadFromApi() async {
    var apiProvider = PesanApiProvider();
    await apiProvider.getAllRemoteData();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    void _onTapItem(BuildContext context, Pesan pesan, String author) {
      _loadFromApi();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DetailPage(
                pesan: pesan,
                author: author,
              )));

      print(author);
    }

    Widget listViewWidget(List<Pesan> pesan) {
      print(pesan.length);

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
                      hoverColor: Colors.black,
                      //Header
                      leading: Container(
                          child: Column(
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage:
                                  getImage('${pesan[position].author}')),
                          Text(
                            '${pesan[position].author}',
                            style: TextStyle(
                                fontWeight: isRead(pesan[position].isRead)),
                          )
                        ],
                      )),

                      title: Text(
                        '${pesan[position].title}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: isRead(pesan[position].isRead)),
                      ),

                      subtitle: Text(
                        '${pesan[position].content}',
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: isRead(pesan[position].isRead)),
                      ),

                      // Footer
                      trailing: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${pesan[position].tanggal}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isRead(pesan[position].isRead)),
                            ),
                            Text('${pesan[position].waktu}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight:
                                        isRead(pesan[position].isRead))),
                            iconIsRead(pesan[position].isRead)
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
        future: DBProvider.db.getAllPesan(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? listViewWidget(snapshot.data)
              : Center(
                  child: Expanded(
                      child: Shimmer.fromColors(
                  baseColor: Colors.blueGrey[100],
                  highlightColor: Colors.white,
                  enabled: true,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 30),
                      // padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48.0,
                            height: 48.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            // padding: EdgeInsets.fromLTRB(10, 10, 20, 10)
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 12.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    // padding: EdgeInsets.only(top: 20)
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 30.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    // padding: EdgeInsets.only(top: 5)
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    itemCount: 6,
                  ),
                )));
        },
      ),
    );
  }
}
