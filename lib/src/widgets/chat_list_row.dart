import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/chat.dart';

class ChatListRow extends StatelessWidget {
  final Chat chat;

  ChatListRow({this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
                child: Image.asset(
              'assets/images/${chat.image}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${chat.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '${chat.lastMessage}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 16.0,
          // ),
          Expanded(
            flex: 2,
            child: Text(
              '${chat.date}',
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
