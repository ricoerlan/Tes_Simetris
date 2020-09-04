
import 'package:flutter/material.dart';
import 'package:tes_simetris/detail_pesan.dart';

import 'model/pesan.dart';

class ListPage extends StatefulWidget {
   final String title ;

  ListPage({Key key, this.title}) : super (key : key);

 


  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List pesan;

  @override
  void initState() {
    pesan = getPesan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      centerTitle: true,
      title: Text(widget.title,),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        ),
      ],
    );


    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white,),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white,),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.message, color: Colors.white,),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white,),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );

    ListTile makeListTile(Pesan pesan) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal : 20.0, vertical : 10.0),
      leading: Container(
        padding: EdgeInsets.only(right : 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width : 1.0, color : Colors.white24)
          ),
        ),
        child: Icon(Icons.message, color: Colors.white,),
      ),
      title: Text(
        pesan.title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ) 
      ),
      //Sub tittle 

      subtitle: Row(
        children: <Widget> [
          Expanded(
            flex: 1,
            child: Container(
              // tag : 'hero',
              child: LinearProgressIndicator(
                backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                value: pesan.indicatorValue,
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            )),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left : 10.0),
              child: Text(pesan.level, style : TextStyle(color : Colors.white)),))
        ],
      ),

      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0,),
      onTap: (){

        Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailPage(pesan : pesan))
        );
      },
      );

    Card makeCard(Pesan pesan) => Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal : 10.0, vertical : 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(pesan),
      ),
    );

    


    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: pesan.length,
        itemBuilder: (BuildContext context, int index){
          return makeCard(pesan[index]);
        },
      ),
    );

    

    

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      //appBar: topAppBar,
      body: makeBody,
      //bottomNavigationBar: makeBottom,
      
    );
   
  }

 
}

List getPesan(){
  return [ 
    Pesan(
        title: "Libur Kerja",
        level: "Intermidiate",
        indicatorValue: 1.0,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Pergantian Direktur",
        level: "Penting",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Penambahan Gaji",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Potongan Gaji",
        level: "Penting",
        indicatorValue: 1.0,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Perubahan Sistem Absensi",
        level: "Penting",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Update Data",
        level: "Normal",
        indicatorValue: 0.33,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Berita Duka",
        level: "Penting",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
 
  ];
}

