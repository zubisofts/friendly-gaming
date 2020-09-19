import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/screens/homescreen.dart';
import 'package:friendly_gaming/src/screens/reset_password_screen.dart';
import 'package:friendly_gaming/src/screens/signup_screen.dart';
import 'package:friendly_gaming/src/screens/timeline_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/gaming_img3.jpg',
                    fit: BoxFit.cover)),
          ),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16))),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Enter password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16))),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox.shrink(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordScreen()));
                                },
                                child: Text('Forgot Password?',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 32),
                            width: MediaQuery.of(context).size.width,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                              },
                              child: Text(
                                'SEND',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          )
                        ],
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/fb.png'),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/twitter1.png'),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/google.png'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen())),
                            child: Text(
                              "Signup Now",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
