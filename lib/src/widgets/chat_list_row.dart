import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/chat.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/screens/message_screen.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:page_transition/page_transition.dart';

class ChatListRow extends StatefulWidget {
  final Chat chat;

  ChatListRow({this.chat});

  @override
  _ChatListRowState createState() => _ChatListRowState();
}

class _ChatListRowState extends State<ChatListRow> {
  Stream<User> userStream;
  User userInfo;

  @override
  void initState() {
    userStream = DataRepository().userDetails(widget.chat.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: MessageScreen(
                user: userInfo,
              ))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: StreamBuilder<User>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User user = snapshot.data;
                      userInfo = user;
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            CachedNetworkImageProvider('${user.photo}'),
                      );
                    }
                    // if (snapshot.error) {
                    //   return Text('Error');
                    // }
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/profile_icon.png'),
                        ),
                      ],
                    );
                  },
                ),
                // child: Text('shgfsuygehve'),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<User>(
                    stream: userStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        User user = snapshot.data;
                        return Text(
                          '${user.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        );
                      }
                      // if (snapshot.error) {
                      //   return Text('Error');
                      // }
                      return Text('...');
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${widget.chat.lastMessage.message}',
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
                '${FGUtils.getTimeFromTimestamp(widget.chat.timestamp)}',
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
