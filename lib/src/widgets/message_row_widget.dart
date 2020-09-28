import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/message.dart';

class MessageRowWidget extends StatelessWidget {
  final Message message;

  MessageRowWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            child: Text('${message.message}',
                style: TextStyle(
                    color: message.userId == 1 ? Colors.white : Colors.black)),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color:
                    message.userId == 1 ? Colors.blue[400] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(right: 10.0, top: 10.0),
          )
        ],
        mainAxisAlignment: message.userId == 1
            ? MainAxisAlignment.end
            : MainAxisAlignment.start, // aligns the chatitem to right end
      ),
      Row(
          mainAxisAlignment: message.userId == 1
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                '${message.time}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal),
              ),
              margin: EdgeInsets.only(
                  left: message.userId == 1 ? 0.0 : 5.0,
           
                  right: message.userId == 1 ? 16.0 : 0.0),
            )
          ])
    ]));
  }
}
