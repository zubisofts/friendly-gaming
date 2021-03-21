import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/comment.dart';
import 'package:friendly_gaming/src/model/like.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/repository/messaging_repo.dart';
import 'package:friendly_gaming/src/screens/comments_screen.dart';
import 'package:friendly_gaming/src/screens/statistics_screen.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:friendly_gaming/src/widgets/win_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:screenshot/screenshot.dart';

// ignore: must_be_immutable
class TimelineCard extends StatefulWidget {
  Post timelineData;

  TimelineCard({this.timelineData});

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  Stream firstUserStream;
  Stream secondUserStream;

  User user1, user2;
  ScreenshotController screenshotController = ScreenshotController();

  var _commentsStream;
  var _likesStream;

  @override
  void initState() {
    firstUserStream =
        DataRepository().userDetails(widget.timelineData.firstPlayerId);
    secondUserStream =
        DataRepository().userDetails(widget.timelineData.secondPlayerId);
    _commentsStream = MessagingRepository().comments(widget.timelineData.id);
    _likesStream = MessagingRepository().likes(widget.timelineData.id);
    context.read<DataBloc>().add(FetchCommentsEvent(widget.timelineData.id));
    context.read<DataBloc>().add(FetchLikesEvent(widget.timelineData.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      StreamBuilder<User>(
                        stream: firstUserStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            user1 = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StatisticsScreen(
                                          user: user1,
                                        )));
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        '${user1.photo}'),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    user1.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  )
                                ],
                              ),
                            );
                          }
                          // if (snapshot.error) {
                          //   return Text('Error');
                          // }
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    'assets/images/profile_icon.png'),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/${widget.timelineData.gameType == 'FIFA' ? 'fifa.png' : 'pes.png'}',
                      width: 20,
                      height: 90,
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      StreamBuilder<User>(
                        stream: secondUserStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            user2 = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StatisticsScreen(
                                          user: user2,
                                        )));
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        '${user2.photo}'),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    user2.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  )
                                ],
                              ),
                            );
                          }
                          // if (snapshot.error) {
                          //   return Text('Error');
                          // }
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    'assets/images/profile_icon.png'),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.timelineData.scores['firstPlayerScore']}',
                      style: TextStyle(
                          color:
                              (widget.timelineData.scores['firstPlayerScore'] >
                                          widget.timelineData
                                              .scores['secondPlayerScore'] ||
                                      widget.timelineData
                                              .scores['firstPlayerScore'] ==
                                          widget.timelineData
                                              .scores['secondPlayerScore'])
                                  ? Colors.green
                                  : Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      'Score',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.timelineData.scores['secondPlayerScore']}',
                      style: TextStyle(
                          color:
                              (widget.timelineData.scores['secondPlayerScore'] >
                                          widget.timelineData
                                              .scores['firstPlayerScore'] ||
                                      widget.timelineData
                                              .scores['firstPlayerScore'] ==
                                          widget.timelineData
                                              .scores['secondPlayerScore'])
                                  ? Colors.green
                                  : Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            WinSwitch(
                firstPlayerScore:
                    widget.timelineData.scores['firstPlayerScore'],
                secondPlayerScore:
                    widget.timelineData.scores['secondPlayerScore']),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<List<Like>>(
                  stream: _likesStream,
                  builder: (context, snapshot) {
                    List<Like> likes = [];
                    if (snapshot.hasData) {
                      likes = snapshot.data;
                    }
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (likes
                                    .where(
                                        (like) => like?.userId == AuthBloc.uid)
                                    .length >
                                0) {
                              context.read<DataBloc>().add(RemoveLikeEvent(
                                  postId: widget.timelineData.id,
                                  likeId: AuthBloc.uid));
                            } else {
                              context.read<DataBloc>().add(AddLikeEvent(Like(
                                  postId: widget.timelineData.id,
                                  userId: AuthBloc.uid,
                                  id: AuthBloc.uid,
                                  time:
                                      DateTime.now().millisecondsSinceEpoch)));
                            }
                          },
                          icon: Icon(Icons.favorite,
                              color: likes
                                          .where((like) =>
                                              like?.userId == AuthBloc.uid)
                                          .length >
                                      0
                                  ? Colors.redAccent
                                  : Colors.blueGrey),
                        ),
                        Text(
                          '${likes.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        IconButton(
                            onPressed: () => showBarModalBottomSheet(
                                  expand: false,
                                  // isScrollControlled: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0))),
                                  builder: (context) =>
                                      CommentsScreen(widget.timelineData),
                                ),
                            icon: Icon(Icons.message, color: Colors.blueGrey)),
                        StreamBuilder<List<Comment>>(
                          stream: _commentsStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data.length}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                ),
                              );
                            }
                            return Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                IconButton(
                    icon: Icon(Icons.share, color: Colors.blueGrey),
                    onPressed: () async {
                      if (user1 != null && user2 != null) {
                        var imgData = await screenshotController.capture();
                        if (imgData != null) {
                          // var imgFile = File.fromRawPath(imgData);
                          await FGUtils.shareScore("Share Match Score", imgData,
                              'Hello! here is the match result from our SURUU gaming challenge:\n${user1.name}  ${widget.timelineData.scores['firstPlayerScore']} - ${widget.timelineData.scores['secondPlayerScore']} ${user2.name}');
                        }
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
