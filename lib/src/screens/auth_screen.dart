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
              // backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              title: Text(
                'Signup',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color),
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).textTheme.headline6.color),
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
