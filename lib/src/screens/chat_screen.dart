import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/widgets/chat_list_row.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ChatListRow(),
            ChatListRow(),
            ChatListRow(),
            ChatListRow(),
            ChatListRow(),
            ChatListRow(),
            ChatListRow(),
          ],
        ),
      ),
    );
  }
}
