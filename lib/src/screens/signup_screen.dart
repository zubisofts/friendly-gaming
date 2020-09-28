import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatelessWidget {
  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Confirm?'),
        content: new Text('Do you want to logout of this App?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          FlatButton(
            onPressed: () {
              context.bloc<AuthBloc>().add(LogoutEvent());
              Navigator.of(context).pop(true);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Sign Up', style: TextStyle(color: Colors.black)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {}),
      ),
      body: WillPopScope(
        onWillPop:()=> _onWillPop(context),
        child: Stack(children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        padding: EdgeInsets.all(1),
                        // width: 100,
                        // height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is OnSignupFormSubmittedState) {
                              if (state.photo != null)
                                return ClipOval(
                                    child: Image.file(
                                  state.photo,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ));
                            }
                            return ClipOval(
                              child: Image.asset(
                                'assets/images/profile_icon.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset:
                                      Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                                color: Colors.black45,
                                onPressed: () async {
                                  File file = await getImage();
                                  context.bloc<AuthBloc>().add(
                                      OnSubmitSignupDetailsEvent(
                                          photo: file, which: 0));
                                })),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SignupForm(),
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
                  SocialSignupForm(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen())),
                        child: Text(
                          "Login Now",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitWanderingCubes(
                        color: Colors.blue,
                        size: 70.0,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Loading',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              }
              if (state is AuthErrorState) {
                return SizedBox.shrink();
              }
              return SizedBox.shrink();
            },
            listener: (context, state) {
              if (state is AuthErrorState) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Error:${state.errorMessage}'),
                ));
              }
            },
          )
        ]),
      ),
    );
  }
}

class SocialSignupForm extends StatelessWidget {
  const SocialSignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: ()=>context.bloc<AuthBloc>().add(SignupWithFacebokEvent()),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Image.asset('assets/icons/fb.png'),
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Image.asset('assets/icons/twitter1.png'),
        ),
        GestureDetector(
          onTap: () => context.bloc<AuthBloc>().add(SignupWithGoogleEvent()),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Image.asset('assets/icons/google.png'),
          ),
        )
      ],
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              bool isNameValid = true;
              if (state is OnSignupFormSubmittedState) {
                isNameValid = state.nameRes;
              }
              return TextFormField(
                onChanged: (name) => context
                    .bloc<AuthBloc>()
                    .add(OnSubmitSignupDetailsEvent(name: name, which: 1)),
                decoration: InputDecoration(
                    hintText: 'Enter name',
                    errorText: isNameValid ? null : 'Name must not be empty',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              );
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Email',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              bool isEmailValid = true;
              if (state is OnSignupFormSubmittedState) {
                isEmailValid = state.emailRes;
              }
              return TextFormField(
                onChanged: (email) => context
                    .bloc<AuthBloc>()
                    .add(OnSubmitSignupDetailsEvent(email: email, which: 2)),
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    errorText: isEmailValid ? null : 'Invalid email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              );
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Password',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              bool isPasswordValid = true;
              if (state is OnSignupFormSubmittedState) {
                isPasswordValid = state.passwordRes;
              }
              return TextFormField(
                onChanged: (password) => context.bloc<AuthBloc>().add(
                    OnSubmitSignupDetailsEvent(password: password, which: 3)),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    errorText: isPasswordValid ? null : 'Invalid password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              );
            },
          ),
          SizedBox(
            height: 12.0,
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateChangedState) {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              bool isNameValid = false;
              bool isEmailValid = false;
              bool isPasswordValid = false;

              if (state is OnSignupFormSubmittedState) {
                isNameValid = state.nameRes;
                isEmailValid = state.emailRes;
                isPasswordValid = state.passwordRes;
              }
              return Container(
                margin: EdgeInsets.only(top: 32),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  onPressed: () {
                    if (isNameValid && isEmailValid && isPasswordValid) {
                      context
                          .bloc<AuthBloc>()
                          .add(SignupWithEmailAndPasswordEvent());
                    }
                  },
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: (isNameValid && isEmailValid && isPasswordValid)
                      ? Colors.blue
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
