import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
        ),
      home: HomePage(),
    );
  }
}
  class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child:Container(
              color: Colors.blue.withOpacity(0.9)
              ),
              clipper: getCliper(),
              ),
              Positioned(
                width :350.0,
                top :MediaQuery.of(context).size.height/4,
                child:Column(  
                  children:<Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color : Colors.blue,
                      image : DecorationImage(
                        image : NetworkImage("http://placeimg.com/640/480/tech/grayscale"),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(75.0),
                    ),
                  ),
                  
                  SizedBox(
                    height :30.0
                  ),
                  Text(
                    'Nama',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15.0,
                  ),
                  Text(
                    'Profile',
                    style:TextStyle(
                      fontSize:17.0,
                      fontStyle:FontStyle.italic,
                      )
                   )
                ]
              )
            )
          ],
        ),
        
      );
    }
  }



  class getCliper extends CustomClipper<Path>
  {
    @override
    Path getClip(Size size){
      var path = new Path();

      path.lineTo(0.0 ,size.height /1.9);
      path.lineTo(size.width + 125,0.0);
      
      path.close();
      return path;
    }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
      return true;  
  }
  }
