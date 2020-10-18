import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/screens/login_screen.dart';
import 'package:friendly_gaming/src/screens/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin;

  @override
  void initState() {
    isLogin = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLogin
          ? null
          : AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
              title: Text('Signup',
               style: TextStyle(color: Colors.black),),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  }),
            ),
      body: isLogin
          ? LoginScreen(() {
              setState(() {
                print('Signup');
                isLogin = false;
              });
            })
          : SignupScreen(() {
              setState(() {
                print('Login');
                isLogin = true;
              });
            }),
    );
  }
}
