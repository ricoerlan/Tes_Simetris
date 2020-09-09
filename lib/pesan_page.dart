
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tes_simetris/detail_pesan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'model/pesan.dart';

class ListPage extends StatefulWidget {
   final String title ;

  ListPage({Key key, this.title,}) : super (key : key);

 


  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String iconUrl;
  String id_sk = "2";

  
  Future<List<Pesan>> getData () async{

    List<Pesan> list;

    String link = "http://hipmagazine.000webhostapp.com/Simetris/getAllMessages.php?id_sk=$id_sk";

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

  AssetImage getImage(String sk){
    if(sk == '1'){
      return AssetImage("assets/065-manager.png");
    }else if(sk == '2'){
      return AssetImage("assets/030-mechanic.png");
    }else if(sk == '3'){
      return AssetImage("assets/060-nurse.png");
    }else{
      return AssetImage("assets/039-marketing.png");
    };
  }

  


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
              elevation: 2.0,
              child: Container(
                height: 100.0,
                width: 120.0,
                child: Center(
                  child: ListTile(

                    //Header
                    leading: Container(
                      padding: EdgeInsets.all(0.0),
                      child: CircleAvatar(backgroundImage: getImage('${pesan[position].id_sk}'))
                    ),

                    title: Text(
                            '${pesan[position].title}',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    
                    subtitle: Text('${pesan[position].content}', maxLines: 2,),

                    // Footer 
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
      backgroundColor: Colors.blue[50],
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.data != null ? listViewWidget(snapshot.data) : Center(child:SpinKitChasingDots(color: Colors.blue, size: 80,));
        },

      ),
      //body: makeBody,
      
      
    );
   
  }

 
}

