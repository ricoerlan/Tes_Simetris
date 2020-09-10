import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();

}



class _WelcomeState extends State<Welcome> {

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/login');
  }

  startTime() async{
    var _duration = Duration(seconds : 4);
    return Timer(_duration , navigationPage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child : SpinKitDualRing(
          color : Colors.white,
          size: 80.0,
        )
      ),
    );
    
  }
}