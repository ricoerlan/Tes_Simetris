import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/custome/color.dart';
import 'package:tes_simetris/ui/dashboard.dart';
import 'package:tes_simetris/ui/pesan_page.dart';
import 'package:tes_simetris/ui/profile_page.dart';

import '../database/db/db_profider.dart';
import '../database/db/db_profider.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    // DBProvider dbProvider;
    // dbProvider.deleteAllPesan();
    DBProvider.db.deleteAllPesan();
    setState(() {
      widget.signOut();
    });
  }

  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Text getTitle() {
    if (_selectedTabIndex == 0) {
      return Text('Dashboard');
    } else if (_selectedTabIndex == 1) {
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
    // TODO: implement initState
    super.initState();
    getPref();
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

    final _bottomNavBar = BottomNavigationBar(
      backgroundColor: AppColors.lightBlue,
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      onTap: _onNavBarTapped,
    );

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
      body: Center(child: _listPage[_selectedTabIndex]),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
