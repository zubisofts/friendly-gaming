import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/dial_screen.dart';
import 'package:friendly_gaming/src/widgets/chat_input.dart';
import 'package:friendly_gaming/src/widgets/message_row_widget.dart';

class MessageScreen extends StatefulWidget {
  final User user;

  MessageScreen({this.user});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    context
        .read<DataBloc>()
        .add(FetchMessagesEvent(receiverId: widget.user.id));
    super.initState();
  }

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
        // centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Expanded(
            //   flex: 1,
            //   child: CircleAvatar(
            //     radius: 40.0,
            //     backgroundImage: CachedNetworkImageProvider(widget.user.photo),
            //   ),
            // ),
            SizedBox(width: 8),
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
            icon: Icon(Icons.call, color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    DialScreen(user: widget.user))),
          ),
          IconButton(
            icon: Icon(Icons.video_call,
                color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    DialScreen(user: widget.user))),
          ),
        ],
      ),
      body: BlocBuilder<DataBloc, DataState>(
        buildWhen: (previous, current) => current is MessagesFetchedState,
        builder: (context, state) {
          List<Message> messages = [];
          if (state is MessagesFetchedState) {
            messages = state.messages;
            Timer(Duration(microseconds: 400), () {
              if (_scrollController.hasClients)
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
            });
          }
          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/empty_chat.svg',
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              'Send a message to ${widget.user.name} to start a conversation.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MessageRowWidget(message: messages[index]);
                        },
                      ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: ChatInput(
                  receiverId: widget.user.id,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
