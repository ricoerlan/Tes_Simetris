import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tes_simetris/base/home.dart';
import 'package:tes_simetris/services/firebase_notification.dart';
import 'package:toast/toast.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(home: Login(), theme: ThemeData()));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  int STATUS;

  String MU_USERNAME,
      MU_PASSWORD,
      MP_NAMA,
      MPG_NAMA_GELAR,
      MPG_NAMA,
      MP_UNIT,
      USERNAME;

  var MU_NIP,
      MPG_NIP,
      MPG_HANDKEY,
      MP_NIP,
      MPG_HP,
      MP_SMF,
      MPG_SMF,
      MSU_KODE,
      MST_GROUP_MG_ID,
      TSD_TGL_AWAL,
      TSD_TGL_AKHIR,
      TSD_NOSK,
      STATUS_SIP,
      MSMF_KODE,
      MU_ID,
      MPG_KODE,
      MU_IS_AKTIF,
      MP_IS_AKTIF,
      MPG_IS_AKTIF,
      MPG_TIPE_PEGAWAI,
      MU_USERID,
      menuTree;

  final _key = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isLogin;
  bool _secureText = true;
  LoginStatus _loginStatus = LoginStatus.notSignIn;

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
    } else {
      Toast.show("Username/Password masih kosong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  // login() async {
  //   final response = await http.post(
  //       "http://android.simetris.net/index.php/info/login/auth",
  //       body: {"inputUsername": email, "inputPassword": password});
  //   final data = jsonDecode(response.body);
  //   status = data['status'];
  //   String pesan = data['msg'];
  //   MU_ID = data['data']['MU_ID'];
  //   MPG_KODE = data['data']['MPG_KODE'];
  //   MU_NIP = data['data']['MU_NIP'];
  //   MPG_NIP = data['data']['MPG_NIP'];
  //   MU_USERNAME = data['data']['MU_USERNAME'];
  //   MU_PASSWORD = data['data']['MU_PASSWORD'];
  //   MPG_HANDKEY = data['data']['MPG_HANDKEY'];
  //   MU_IS_AKTIF = data['data']['MU_IS_AKTIF'];
  //   MP_NIP = data['data']['MP_NIP'];
  //   MP_NAMA = data['data']['MP_NAMA'];
  //   MPG_NAMA_GELAR = data['data']['MPG_NAMA_GELAR'];
  //   MPG_NAMA = data['data']['MPG_NAMA'];
  //   MPG_HP = data['data']['MPG_HP'];
  //   MP_SMF = data['data']['MP_SMF'];
  //   MPG_SMF = data['data']['MPG_SMF'];
  //   MP_IS_AKTIF = data['data']['MP_IS_AKTIF'];
  //   MPG_IS_AKTIF = data['data']['MPG_IS_AKTIF'];
  //   MP_UNIT = data['data']['MP_UNIT'];
  //   MSU_KODE = data['data']['MSU_KODE'];
  //   MST_GROUP_MG_ID = data['data']['MST_GROUP_MG_ID'];
  //   MPG_TIPE_PEGAWAI = data['data']['MPG_TIPE_PEGAWAI'];
  //   TSD_TGL_AWAL = data['data']['TSD_TGL_AWAL'];
  //   TSD_TGL_AKHIR = data['data']['TSD_TGL_AKHIR'];
  //   TSD_NOSK = data['data']['TSD_NOSK'];
  //   STATUS_SIP = data['data']['STATUS_SIP'];
  //   MSMF_KODE = data['data']['MSMF_KODE'];
  //   MU_USERID = data['data']['MU_USERID'];
  //   USERNAME = data['data']['USERNAME'];
  //   isLogin = data['data']['isLogin'];
  //   menuTree = data['data']['menuTree'];

  //   // String username = email;
  //   // String nama_user = data['data']['MP_NAMA'];
  //   // String mp_nip = data['data']['MP_NIP'];
  //   // String mp_unit = data['data']['MP_UNIT'];
  //   if (status == 1) {
  //     setState(() {
  //       _loginStatus = LoginStatus.signIn;
  //       savePref(
  //           status,
  //           MU_ID,
  //           MPG_KODE,
  //           MU_NIP,
  //           MPG_NIP,
  //           MU_USERNAME,
  //           MU_PASSWORD,
  //           MPG_HANDKEY,
  //           MU_IS_AKTIF,
  //           MP_NIP,
  //           MP_NAMA,
  //           MPG_NAMA_GELAR,
  //           MPG_NAMA,
  //           MPG_HP,
  //           MP_SMF,
  //           MPG_SMF,
  //           MP_IS_AKTIF,
  //           MPG_IS_AKTIF,
  //           MP_UNIT,
  //           MSU_KODE,
  //           MST_GROUP_MG_ID,
  //           MPG_TIPE_PEGAWAI,
  //           TSD_TGL_AWAL,
  //           TSD_TGL_AKHIR,
  //           TSD_NOSK,
  //           STATUS_SIP,
  //           MSMF_KODE,
  //           MU_USERID,
  //           USERNAME,
  //           isLogin);
  //     });

  //     _firebaseMessaging.getToken().then((token) {
  //       print("firebase tokens : $token");

  //       print("MU_ID: $MU_ID");
  //       print("MP_NIP: $MP_NIP");
  //       print("MP_NAMA: $MP_NAMA");
  //       print("MP_UNIT: $MP_UNIT");
  //       print("pesan: $pesan");

  //       final responses = http.post(
  //           "http://jogjamotor24jam.com/updateDeviceToken.php",
  //           body: {"email": email, "DeviceToken": token});
  //     });

  //     print("pesan: ");
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => HomePage(),
  //     //   ),
  //     // );
  //   } else {
  //     print(pesan);
  //   }
  // }

  login() async {
    final response = await http.post(
        "http://jogjamotor24jam.com/login_simetris.php",
        body: {"MU_USERNAME": MU_USERNAME, "MU_PASSWORD": MU_PASSWORD});
    final data = jsonDecode(response.body);

    if (data['STATUS'] == 1) {
      Toast.show("Login Berhasil", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      STATUS = data['STATUS'];
      String MESSAGE = data['MESSAGE'];
      String ID_USER = data['ID_USER'];
      String ID_SK = data['ID_SK'];
      MP_UNIT = data['MP_UNIT'];
      MP_NAMA = data['MP_NAMA'];
      MU_NIP = data['MU_NIP'];
      MPG_HP = data['MPG_HP'];
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(STATUS, ID_USER, ID_SK, MP_UNIT, MP_NAMA, MU_NIP, MPG_HP);
      });

      _firebaseMessaging.getToken().then((token) {
        print("firebase tokens : $token");
        print("ID_SK: $ID_SK");

        final responses = http.post(
            "http://jogjamotor24jam.com/updateDeviceToken.php",
            body: {"MU_USERNAME": MU_USERNAME, "DEVICE_TOKEN": token});
      });
      print(MESSAGE);
    } else {
      Toast.show("Login Gagal", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  savePref(int STATUS, String ID_USER, ID_SK, MP_UNIT, MP_NAMA, MU_NIP,
      MPG_HP) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("STATUS", STATUS);
      preferences.setString("ID_USER", ID_USER);
      preferences.setString("ID_SK", ID_SK);
      preferences.setString("MP_UNIT", MP_UNIT);
      preferences.setString("MP_NAMA", MP_NAMA);
      preferences.setString("MU_NIP", MU_NIP);
      preferences.setString("MPG_HP", MPG_HP);
      preferences.commit();
    });
  }

  // savePref(
  //     int status,
  //     // String id_user,
  //     // String mp_unit,
  //     // String nama,
  //     // String username,
  //     String MU_ID,
  //     String MPG_KODE,
  //     String MU_NIP,
  //     String MPG_NIP,
  //     String MU_USERNAME,
  //     String MU_PASSWORD,
  //     String MPG_HANDKEY,
  //     String MU_IS_AKTIF,
  //     String MP_NIP,
  //     String MP_NAMA,
  //     String MPG_NAMA_GELAR,
  //     String MPG_NAMA,
  //     String MPG_HP,
  //     String MP_SMF,
  //     String MPG_SMF,
  //     String MP_IS_AKTIF,
  //     String MPG_IS_AKTIF,
  //     String MP_UNIT,
  //     String MSU_KODE,
  //     String MST_GROUP_MG_ID,
  //     String MPG_TIPE_PEGAWAI,
  //     String TSD_TGL_AWAL,
  //     String TSD_TGL_AKHIR,
  //     String TSD_NOSK,
  //     String STATUS_SIP,
  //     String MSMF_KODE,
  //     String MU_USERID,
  //     String USERNAME,
  //     bool isLogin
  //     // var menuTree,
  //     ) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("status", status);
  //     preferences.setString("MU_ID", MU_ID);
  //     preferences.setString("MPG_KODE", MPG_KODE);
  //     preferences.setString("MPG_NIP", MPG_NIP);
  //     preferences.setString("MU_USERNAME", MU_USERNAME);
  //     preferences.setString("MU_PASSWORD", MU_PASSWORD);
  //     preferences.setString("MPG_HANDKEY", MPG_HANDKEY);
  //     preferences.setString("MU_IS_AKTIF", MU_IS_AKTIF);
  //     preferences.setString("MP_NIP", MP_NIP);
  //     preferences.setString("MP_NAMA", MP_NAMA);
  //     preferences.setString("MPG_NAMA_GELAR", MPG_NAMA_GELAR);
  //     preferences.setString("MPG_NAMA", MPG_NAMA);
  //     preferences.setString("MPG_HP", MPG_HP);
  //     preferences.setString("MP_SMF", MP_SMF);
  //     preferences.setString("MPG_SMF", MPG_SMF);
  //     preferences.setString("MP_IS_AKTIF", MP_IS_AKTIF);
  //     preferences.setString("MPG_IS_AKTIF", MPG_IS_AKTIF);
  //     preferences.setString("MP_UNIT", MP_UNIT);
  //     preferences.setString("MSU_KODE", MSU_KODE);
  //     preferences.setString("MST_GROUP_MG_ID", MST_GROUP_MG_ID);
  //     preferences.setString("MPG_TIPE_PEGAWAI", MPG_TIPE_PEGAWAI);
  //     preferences.setString("TSD_TGL_AWAL", TSD_TGL_AWAL);
  //     preferences.setString("TSD_TGL_AKHIR", TSD_TGL_AKHIR);
  //     preferences.setString("TSD_NOSK", TSD_NOSK);
  //     preferences.setString("STATUS_SIP", STATUS_SIP);
  //     preferences.setString("MSMF_KODE", MSMF_KODE);
  //     preferences.setString("MU_USERID", MU_USERID);
  //     preferences.setString("USERNAME", USERNAME);
  //     preferences.setBool("isLogin", isLogin);
  //     // preferences.setString("MU_NIP", MU_NIP);

  //     // preferences.setString("id_user", id_user);
  //     // preferences.setString("mp_unit", mp_unit);
  //     // preferences.setString("nama", nama);
  //     // preferences.setString("email", email);
  //     preferences.commit();
  //   });
  // }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      STATUS = preferences.getInt("STATUS");

      _loginStatus = STATUS == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("STATUS", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    Firebasess(context: context).initNotifications();
    _firebaseMessaging.getToken().then((token) {
      print("firebase token : $token");
    });
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
                      return "Please insert Username";
                    }
                  },
                  onSaved: (e) => MU_USERNAME = e,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => MU_PASSWORD = e,
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
        return MainMenu(selectTab: 2);
        break;
    }
  }
}
