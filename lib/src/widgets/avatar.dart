import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  double size;
  String image;
  String name;
  Avatar({this.size, this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
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
            'assets/images/${image}',
            width: size,
            height: size,
            fit: BoxFit.cover,
          )),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
