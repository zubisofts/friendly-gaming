import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/chat.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/screens/message_screen.dart';
import 'package:friendly_gaming/src/widgets/chat_list_row.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: Chat.getChats()
              .map((chat) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MessageScreen(
                              messages: Message.getMessages(),
                            ))),
                    child: ChatListRow(
                      chat: chat,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
