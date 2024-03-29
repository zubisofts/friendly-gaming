import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/message.dart';

class ChatInput extends StatefulWidget {
  final String receiverId;

  ChatInput({this.receiverId});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Text input
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 15.0,
                ),
                controller: textEditingController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  Message message = Message(
                      id: '',
                      senderId: AuthBloc.uid,
                      message: '${textEditingController.text}',
                      mediaType: 'Text',
                      timestamp: DateTime.now().millisecondsSinceEpoch);

                  BlocProvider.of<DataBloc>(context).add(SendMessageEvent(
                      message: message, receiverId: widget.receiverId));

                  textEditingController.clear();
                },
                color: Colors.blue,
              ),
            ),
            color: Theme.of(context).cardColor,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
        border: new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
