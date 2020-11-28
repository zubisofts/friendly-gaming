import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';

class MessageRowWidget extends StatelessWidget {
  final Message message;
  final String myUid = AuthBloc.uid;
  MessageRowWidget({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: message.senderId == myUid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
          Wrap(
            children: <Widget>[
              Bubble(
                child: Text('${message.message}',
                    softWrap: true,
                    style: TextStyle(
                        height: 1.5,
                        color: message.senderId == myUid
                            ? Colors.white
                            : Colors.white)),
                // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                color: message.senderId == myUid
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondary,
                nipRadius: 1.0,
                nip: message.senderId == myUid
                    ? BubbleNip.rightTop
                    : BubbleNip.leftTop,
                margin: BubbleEdges.only(
                    right: message.senderId == myUid ? 10.0 : 40.0,
                    top: 24.0,
                    left: message.senderId == myUid ? 40.0 : 10.0),
              )
            ],
            runAlignment: WrapAlignment.end,

            // crossAxisAlignment: message.senderId == myUid
            //     ? WrapCrossAlignment.end
            //     : WrapCrossAlignment.start, // aligns the chatitem to right end
          ),
          Wrap(
              runAlignment: WrapAlignment.end,
              crossAxisAlignment: message.senderId == myUid
                  ? WrapCrossAlignment.end
                  : WrapCrossAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    '${FGUtils.getTimeFromTimestamp(message.timestamp)}',
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal),
                  ),
                  margin: EdgeInsets.only(
                      right: message.senderId == myUid ? 18.0 : 40.0,
                      top: 5.0,
                      left: message.senderId == myUid ? 40.0 : 18.0),
                )
              ])
        ]));
  }
}
