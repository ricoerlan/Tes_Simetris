import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes_simetris/custome/color.dart';
import 'package:tes_simetris/ui/dashboard.dart';
import 'package:tes_simetris/ui/pesan_page.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
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
      Text('Halaman Profile'),
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
      backgroundColor: AppColors.colorPrimaryDark,
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blue[900],
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Simetris'),
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
