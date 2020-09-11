import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/db/db_profider.dart';
import '../database/db/db_profider.dart';
import '../database/db/db_profider.dart';
import '../model/pesan.dart';

class DetailPage extends StatelessWidget {
  final Pesan pesan;
  final String author;
  final int isRead = 1;

  DetailPage({Key key, this.pesan, this.author}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final String id = pesan.id_message;
    DBProvider.db.isRead(isRead, id);

    print('isRead : $pesan.isRead');

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  pesan.tanggal,
                  style: TextStyle(color: Colors.grey[300], fontSize: 12),
                ),
                Text(pesan.waktu,
                    style: TextStyle(color: Colors.grey[300], fontSize: 11))
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
            child: CircleAvatar(
          backgroundImage: getImage(author),
          maxRadius: 45,
        )),
        Center(
          child: Container(
            width: 90.0,
            child: new Divider(color: Colors.black),
          ),
        ),
        SizedBox(height: 0.0),
        Center(
          child: Text(
            pesan.author,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          pesan.title,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    'Tipe Pesan : ',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text(
                      pesan.level,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/SIMETRIS.png"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(0, 139, 139, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      pesan.content,
      style: TextStyle(fontSize: 18.0),
    );

    final bottomContent = Container(
      //height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width,

      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
