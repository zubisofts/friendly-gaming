import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/timeline_data.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/widgets/score_selector.dart';
import 'package:friendly_gaming/src/widgets/win_switch.dart';

// ignore: must_be_immutable
class EditGameCard extends StatefulWidget {
  Post timelineData;

  EditGameCard({this.timelineData});

  @override
  _EditGameCardState createState() => _EditGameCardState();
}

class _EditGameCardState extends State<EditGameCard> {
  Stream firstUserStream;
  Stream secondUserStream;
  var p1;
  var p2;

  @override
  void initState() {
    firstUserStream =
        DataRepository().userDetails(widget.timelineData.firstPlayerId);
    secondUserStream =
        DataRepository().userDetails(widget.timelineData.secondPlayerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          User user = snapshot.data;
                          p1 = user?.name;
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    CachedNetworkImageProvider('${user.photo}'),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                user.name,
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
                          );
                        }
                        // if (snapshot.error) {
                        //   return Text('Error');
                        // }
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/profile_icon.png'),
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
                          User user = snapshot.data;
                          p2 = user?.name;
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    CachedNetworkImageProvider('${user.photo}'),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                user.name,
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
                          );
                        }
                        // if (snapshot.error) {
                        //   return Text('Error');
                        // }
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/profile_icon.png'),
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
                        color: (widget.timelineData.scores['firstPlayerScore'] >
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
              firstPlayerScore: widget.timelineData.scores['firstPlayerScore'],
              secondPlayerScore:
                  widget.timelineData.scores['secondPlayerScore']),
          SizedBox(
            height: 8,
          ),
          Container(
            // width: 200,
            width: !(widget.timelineData.updates.contains(AuthBloc.uid))
                ? 150
                : MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: !(widget.timelineData.updates.contains(AuthBloc.uid))
                  ? () => showBarModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            EditScoreWidget(widget.timelineData, p1, p2),
                      )
                  : null,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    !(widget.timelineData.updates.contains(AuthBloc.uid))
                        ? Icons.edit
                        : Icons.history_outlined,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Text(
                        '${!(widget.timelineData.updates.contains(AuthBloc.uid)) ? 'Edit Score' : 'Waiting for opponent to confirm score'}',
                        style: TextStyle(
                            color: !(widget.timelineData.updates
                                    .contains(AuthBloc.uid))
                                ? Theme.of(context).textTheme.headline6.color
                                : Colors.orange)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EditScoreWidget extends StatelessWidget {
  final Post post;
  final player1Name;
  final player2Name;

  int score1, score2;
  Map<String, dynamic> data = {};

  EditScoreWidget(this.post, this.player1Name, this.player2Name) : super() {
    score1 = post.scores['firstPlayerScore'];
    score2 = post.scores['secondPlayerScore'];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        if (state is PostEditedState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.0),
              content: Text('Scores updated successfully',
                  style: TextStyle(fontSize: 16.0))));
        }

        if (state is PostEditErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.0),
              content: Text('There was an error updating the scores',
                  style: TextStyle(fontSize: 16.0))));
        }
      },
      builder: (context, state) {
        return Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$player1Name',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      ScoreSelector(
                        initialValue: post.scores['firstPlayerScore'],
                        onSelect: (score) {
                          score1 = score;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$player2Name',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      ScoreSelector(
                        initialValue: post.scores['secondPlayerScore'],
                        onSelect: (score) {
                          score2 = score;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 45.0,
                  onPressed: () {
                    data['scores'] = <String, int>{
                      'firstPlayerScore': score1,
                      'secondPlayerScore': score2,
                    };
                    if (post.updates.length > 0) {
                      data['status'] = 'completed';
                    }
                    data['updates'] = post.updates..add(AuthBloc.uid);
                    context.read<DataBloc>().add(EditPostEvent(data, post.id));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Update Now',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
