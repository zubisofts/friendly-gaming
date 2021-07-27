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
            backgroundColor: Theme.of(context).cardColor,
            title: new Text(
              'Confirm?',
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
            ),
            content: new Text(
              'Do you want to logout of this App?',
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color),
                ),
              ),
              FlatButton(
                onPressed: () {
                  context.bloc<AuthBloc>().add(LogoutEvent());
                  Navigator.of(context).pop(true);
                },
                child: new Text(
                  'Yes',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color),
                ),
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
          return state.user != null
              ? HomeScreen(user: state.user)
              : AuthScreen();
        }

        return AuthScreen();
      }),
    ));
  }
}
