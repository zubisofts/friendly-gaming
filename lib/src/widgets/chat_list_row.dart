import 'package:flutter/material.dart';

class ChatListRow extends StatelessWidget {
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
              'assets/images/img6.png',
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
                  'Andy Jorden',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Here is a message from Andy, please reply if seen',
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
              '10:55 PM',
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
