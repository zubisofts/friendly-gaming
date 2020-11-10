import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/dial_screen.dart';
import 'package:friendly_gaming/src/screens/incoming_call_screen.dart';
import 'package:friendly_gaming/src/widgets/chat_input.dart';
import 'package:friendly_gaming/src/widgets/message_row_widget.dart';

class MessageScreen extends StatefulWidget {
  final List<Message> messages;
  final User user;

  MessageScreen({this.messages, this.user});

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
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 0,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: CachedNetworkImageProvider(widget.user.photo),
              ),
            ),
            SizedBox(width:8),            
            Expanded(
              flex: 5,
              child: Text('${widget.user.name}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline6.color)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call,
                color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => DialScreen(user:widget.user))),
          ),
        ],
      ),
      body: Center(child: Text('Messages')),
      //  Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //           itemCount: widget.messages.length,
      //           itemBuilder: (context, index) =>
      //               MessageRowWidget(widget.messages[index])),
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width,
      //       height: 50,
      //       child: ChatInput(),
      //     )
      //   ],
      // ),
    );
  }
}
