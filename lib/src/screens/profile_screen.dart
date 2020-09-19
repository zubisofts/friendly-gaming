import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: ClipOval(
                  child: Image.asset(
                'assets/images/img6.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Anyanwu Nzubechi',
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
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
