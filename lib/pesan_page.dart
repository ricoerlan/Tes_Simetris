
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
    ListTile makeListTile(Pesan pesan) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal : 20.0, vertical : 10.0),
      leading: Container(
        padding: EdgeInsets.only(right : 12.0),
        // decoration: BoxDecoration(
        //   border: Border(
        //     right: BorderSide(width : 1.0, color : Colors.white24)
        //   ),
        // ),
        child: Icon(Icons.message, color: Colors.grey,),
      ),
      title: Text(
        pesan.title,
        style: TextStyle(
          color: Colors.black54,
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
                backgroundColor: Colors.green[200],
                value: pesan.indicatorValue,
                valueColor: AlwaysStoppedAnimation(Colors.green[600]),
              ),
            )),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left : 10.0),
              child: Text(pesan.level, style : TextStyle(color : Colors.black54)),))
        ],
      ),

      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0,),
      onTap: (){

        Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailPage(pesan : pesan))
        );
      },
      );

    Card makeCard(Pesan pesan) => Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal : 12.0, vertical : 3.0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomRight: Radius.circular(16),
      //     topRight: Radius.circular(16),
      //     bottomLeft: Radius.circular(16),
      //     topLeft: Radius.circular(16),
      //   )
      // ),
      child: Container(
        //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
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
      backgroundColor: Colors.blue[100],
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
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Pergantian Jam Kerja",
        level: "Penting",
        indicatorValue: 1.0,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Penambahan Gaji",
        level: "Intermidiate",
        indicatorValue: 0.66,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Potongan Gaji",
        level: "Penting",
        indicatorValue: 1.0,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Perubahan Sistem Absensi",
        level: "Penting",
        indicatorValue: 1.0,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Update Data",
        level: "Normal",
        indicatorValue: 0.33,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Pesan(
        title: "Berita Duka",
        level: "Penting",
        indicatorValue: 1.0,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

