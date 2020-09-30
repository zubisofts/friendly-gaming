import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/screens/homescreen.dart';
import 'package:friendly_gaming/src/screens/auth_screen.dart';

class Wrapper extends StatelessWidget {
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
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthStateChangedState) {
          return state.user != null ? HomeScreen(user:state.user) : AuthScreen();
        }

        return AuthScreen();
      }),
    ));
  }
}
