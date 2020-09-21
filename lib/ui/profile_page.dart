import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/custome/color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String MU_NIP, MP_NAMA, MP_UNIT, MPG_HP;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      MU_NIP = preferences.getString("MU_NIP");
      MP_NAMA = preferences.getString("MP_NAMA");
      MP_UNIT = preferences.getString("MP_UNIT");
      MPG_HP = preferences.getString("MPG_HP");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: MP_NAMA != null
            ? profileView()
            : Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 100,
                ),
              )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 1,
              //     right: 1,
              //     child: Container(
              //       height: 40,
              //       width: 40,
              //       child: Icon(
              //         Icons.add_a_photo,
              //         color: Colors.white,
              //       ),
              //       decoration: BoxDecoration(
              //           color: Colors.deepOrange,
              //           borderRadius: BorderRadius.all(Radius.circular(20))),
              //     ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.blue[50]),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 3, 0, 3),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NAMA",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        MP_NAMA,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 0.5, color: Colors.blueGrey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 3, 0, 3),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NIP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        MU_NIP,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 0.5, color: Colors.blueGrey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 3, 0, 3),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "UNIT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        MP_UNIT,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 0.5, color: Colors.blueGrey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 3, 0, 3),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NO HP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        MPG_HP,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 0.5, color: Colors.blueGrey)),
                  // border: Border.all(width: 1.0, color: Colors.black)),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
