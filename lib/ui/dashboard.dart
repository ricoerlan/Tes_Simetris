import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    // Firebasess(context: context).initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            makeDashboardItem('Cari', Icons.book),
            makeDashboardItem('Data', Icons.alarm),
            makeDashboardItem('Jam', Icons.bookmark),
            makeDashboardItem('Cari', Icons.book),
            makeDashboardItem('Cari', Icons.alarm),
            makeDashboardItem('Cari', Icons.bookmark),
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.all(8.0),
      child: Container(
        //decoration: BoxDecoration(color : Colors.blue[100]),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
