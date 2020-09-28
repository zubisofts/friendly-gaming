import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/widgets/chat_input.dart';
import 'package:friendly_gaming/src/widgets/message_row_widget.dart';

class MessageScreen extends StatefulWidget {
  final List<Message> messages;

  MessageScreen({this.messages});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundImage: AssetImage("assets/images/img2.jpg"),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('Add Post',
                style: TextStyle(fontSize: 16, color: Colors.black))
          ],
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.messages.length,
                itemBuilder: (context, index) =>
                    MessageRowWidget(widget.messages[index])),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ChatInput(),
              )
        ],
      ),
    );
  }
}
