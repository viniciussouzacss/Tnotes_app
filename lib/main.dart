import 'dart:async';
import 'HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreen createState() => _MySplashScreen();
}

class _MySplashScreen extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), openHomePage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Color(0x887D53CC),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color(0xff815FC0),
                          radius: 70.0,
                          child: Icon(
                            Icons.check_sharp,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Text(
                        "Tnotes",
                        style: TextStyle(
                            color: Color(0xff815FC0),
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void openHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
