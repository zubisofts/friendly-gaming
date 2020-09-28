import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/screens/homescreen.dart';
import 'package:friendly_gaming/src/screens/login_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
      if (state is AuthStateChangedState) {
        print('Email:${state.user}');
        if(state.user !=null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        // return state.user != null ? HomeScreen() : LoginScreen();
      }
      // return LoginScreen();
    },child: LoginScreen(),);
  }
}
