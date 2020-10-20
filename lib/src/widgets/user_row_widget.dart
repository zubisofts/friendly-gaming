import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/user.dart';

class UserRowWidget extends StatelessWidget {
  final User user;
  final Function(User) onTap;

  UserRowWidget({this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: ListTile(
        onTap:()=> onTap(user),
        contentPadding: EdgeInsets.all(8.0),
        leading: CircleAvatar(
          radius: 24.0,
          backgroundImage: CachedNetworkImageProvider(user.photo),
        ),
        title: Text(user.name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        subtitle: Text(user.email),
      ),
    );
  }
}
