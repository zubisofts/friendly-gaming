import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/statistics_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({this.user});

  @override
  Widget build(BuildContext context) {
    context.bloc<DataBloc>().add(UserDataEvent(uid: user.id));
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      User user;
      if (state is UserDataState) {
        user = state.user;
        print('*******************User: $user');
      }
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
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
                child: user?.photo != null
                    ? ClipOval(
                        child: Image.network(
                        '${user?.photo}',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ))
                    : ClipOval(
                        child: Image.asset(
                        'assets/images/profile_icon.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${user?.name ?? ''}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.timeline,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Statistics',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StatisticsScreen())),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[200],
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      context.bloc<AuthBloc>().add(LogoutEvent());
                      // Navigator.popUntil(context, ModalRoute.withName('/login'));
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                  )),
            ],
          ),
        ),
      );
    });
  }
}
