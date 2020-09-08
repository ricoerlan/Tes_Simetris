
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tes_simetris/detail_pesan.dart';
import 'package:http/http.dart' as http;

import 'model/pesan.dart';

class ListPage extends StatefulWidget {
   final String title ;

  ListPage({Key key, this.title,}) : super (key : key);

 


  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  
  Future<List<Pesan>> getData () async{

    List<Pesan> list;

    String link = "http://10.1.1.118/login/getAllMessages.php?id_sk=2";

    var res = await http.get(Uri.encodeFull(link));
    print(res.body);

    if (res.statusCode == 200){
      var data = json.decode(res.body);
      var rest = data as List;
      print(rest);

      list = rest.map<Pesan>((json) => Pesan.fromJson(json)).toList();
    }

    print("List Size: ${list.length}");
    return list;

  }



  List<Pesan> pesan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ListTile makeListTile(Pesan pesan) => ListTile(
    //   contentPadding: EdgeInsets.symmetric(horizontal : 20.0, vertical : 10.0),
    //   leading: Container(
    //     padding: EdgeInsets.only(right : 12.0),
    //     // decoration: BoxDecoration(
    //     //   border: Border(
    //     //     right: BorderSide(width : 1.0, color : Colors.white24)
    //     //   ),
    //     // ),
    //     child: Icon(Icons.message, color: Colors.grey,),
    //   ),
    //   title: Text(
    //     pesan.title,
    //     style: TextStyle(
    //       color: Colors.black54,
    //       fontWeight: FontWeight.bold
    //     ) 
    //   ),
    //   //Sub tittle 

    //   subtitle: Row(
    //     children: <Widget> [
    //       Expanded(
    //         flex: 1,
    //         child: Container(
    //           // tag : 'hero',
    //           child: LinearProgressIndicator(
    //             backgroundColor: Colors.green[200],
    //             value: pesan.indicatorValue,
    //             valueColor: AlwaysStoppedAnimation(Colors.green[600]),
    //           ),
    //         )),
    //       Expanded(
    //         flex: 4,
    //         child: Padding(
    //           padding: EdgeInsets.only(left : 10.0),
    //           child: Text(pesan.level, style : TextStyle(color : Colors.black54)),))
    //     ],
    //   ),

    //   trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0,),
    //   onTap: (){

    //     Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => DetailPage(pesan : pesan))
    //     );
    //   },
    //   );

    // Card makeCard(Pesan pesan) => Card(
    //   elevation: 3.0,
    //   margin: EdgeInsets.symmetric(horizontal : 12.0, vertical : 3.0),
    //   // shape: RoundedRectangleBorder(
    //   //   borderRadius: BorderRadius.only(
    //   //     bottomRight: Radius.circular(16),
    //   //     topRight: Radius.circular(16),
    //   //     bottomLeft: Radius.circular(16),
    //   //     topLeft: Radius.circular(16),
    //   //   )
    //   // ),
    //   child: Container(
    //     //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
    //     child: makeListTile(pesan),
    //   ),
    // );


     // final makeBody = Container(
    //   child: ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemCount: pesan.length,
    //     itemBuilder: (BuildContext context, int index){
    //       return makeCard(pesan[index]);
    //     },
    //   ),
    // );

    

     void _onTapItem(BuildContext context, Pesan pesan) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => DetailPage(pesan: pesan,)));
  }

    Widget listViewWidget(List<Pesan> pesan) {
    return Container(
      child: ListView.builder(
          itemCount: pesan.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: Container(
                height: 100.0,
                width: 120.0,
                child: Center(
                  child: ListTile(

                    leading: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.message, color: Colors.grey, size: 35,),
                    ),

                    title: Text(
                            '${pesan[position].title}',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    
                    subtitle: Text('${pesan[position].content}', maxLines: 2,),

                    trailing: Text(
                      '${pesan[position].waktu}',
                      style: TextStyle(fontSize: 10)),
                    onTap: () => _onTapItem(context, pesan[position]),
                  ),
                ),
              ),
            );
          }),
    );
  }
 

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.data != null ? listViewWidget(snapshot.data) : Center(child: CircularProgressIndicator(),);
        },

      ),
      //body: makeBody,
      
      
    );
   
  }

 
}

