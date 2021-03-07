import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 150, left: 32, right: 32, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 45),
                child: Text(
                  'SURUU',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width*0.5,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                // margin: EdgeInsets.symmetric(horizontal: 32.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Play',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    Text('Share',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    Icon(Icons.play_arrow, color: Colors.white),
                    Text('Enjoy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(child: SizedBox.expand()),
              Text(
                'Version 1.0',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }
}
