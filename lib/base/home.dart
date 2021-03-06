import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/custome/color.dart';
import 'package:tes_simetris/database/db/pesan_api_provider.dart';
import 'package:tes_simetris/main.dart';
import 'package:tes_simetris/services/firebase_notification.dart';
import 'package:tes_simetris/ui/dashboard.dart';
import 'package:tes_simetris/ui/pesan_page.dart';
import 'package:tes_simetris/ui/profile_page.dart';

import '../database/db/db_profider.dart';
import '../database/db/db_profider.dart';

class MainMenu extends StatefulWidget {
  final int selectTab;

  MainMenu({Key key, this.selectTab}) : super(key: key);
  // final VoidCallback signOut;
  // MainMenu(this.signOut);
  // int _selectedTabIndex;
  @override
  _MainMenuState createState() => _MainMenuState(selectTab: selectTab);
}

class _MainMenuState extends State<MainMenu> {
  int selectTab;

  _MainMenuState({this.selectTab});

  LoginStatus _loginStatus;

  void _onNavBarTapped(int index) {
    setState(() {
      selectTab = index;
    });
  }

  Text getTitle() {
    if (selectTab == 0) {
      return Text('Dashboard');
    } else if (selectTab == 1) {
      return Text('Pesan');
    } else {
      return Text('Profile');
    }
  }

//  String email = "", nama = "";
//  TabController tabController;

  var email;
  var nama;
  var id_sk;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("email");
      nama = preferences.getString("nama");
      id_sk = preferences.getString("id_sk");
    });
    print(email);
  }

  @override
  void initState() {
    super.initState();
    getPref();
    // Firebasess(context: context).initNotifications();
    var apiProvider = PesanApiProvider();
    apiProvider.getAllRemoteData();
    Future.delayed(const Duration(seconds: 2));
    print(email);
    print(id_sk);
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      Dashboard(),
      ListPage(
        title: 'Halaman Pesan',
      ),
      Profile()
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        title: Text('Pesan'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Profile'),
      ),
    ];

    //Curved Navbar
    // final _curvedNavBar = CurvedNavigationBar(
    //     backgroundColor: Colors.white,
    //     color: AppColors.colorPrimary,
    //       items:
    //       <Widget>[
    //         Icon(Icons.home, size: 30),
    //         Icon(Icons.message, size: 30),
    //         Icon(Icons.person, size: 30),
    //       ];
    //     });

    //Navbar Biasa
    final _bottomNavBar = BottomNavigationBar(
      backgroundColor: AppColors.lightBlue,
      items: _bottomNavBarItems,
      currentIndex: selectTab,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      onTap: _onNavBarTapped,
    );

    signOut() async {
      DBProvider.db.deleteAllPesan();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setInt("STATUS", null);
        preferences.commit();
        _loginStatus = LoginStatus.notSignIn;
      });
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (BuildContext context) => Login()));

      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Login();
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.lock_open),
          )
        ],
      ),
      body: Center(child: _listPage[selectTab]),
      bottomNavigationBar: CurvedNavigationBar(
        // key: _bottomNavigationKey,
        height: 66,
        items: <Widget>[
          Icon(Icons.home, size: 35),
          Icon(Icons.message, size: 35),
          Icon(Icons.person, size: 35),
        ],
        color: Colors.lightBlue,
        // buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blue[50],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            selectTab = index;
          });
        },
      ),
    );
  }
}
