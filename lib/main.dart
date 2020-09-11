import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/ui/welcome.dart';

import 'base/home.dart';

void main() {
  runApp(MaterialApp(
    home: Welcome(),
    theme: ThemeData(),
    routes: <String, WidgetBuilder>{
      '/login' : (BuildContext context) => Login(),
    },
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post("http://jogjamotor24jam.com/login_simetris.php",
        body: {"email": email, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String emailAPI = data['email'];
    String namaAPI = data['nama'];
    String id = data['id'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, namaAPI, id);
      });

      _firebaseMessaging.getToken().then((token) {
        print("firebase token : $token");
        print("email : $email");

        final responses = http.post('http://jogjamotor24jam.com/updateDeviceToken.php',
        body: {"email" : email, "DeviceToken" : token});
      });

      print(pesan);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
    } else {
      print(pesan);
    }
  }

  savePref(int value, String email, String nama, String id, ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Please insert email";
                    }
                  },
                  onSaved: (e) => email = e,
                  decoration: InputDecoration(
                    labelText: "email",
                  ),
                ),
                TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    check();
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainMenu(signOut);
        break;
    }
  }
}
