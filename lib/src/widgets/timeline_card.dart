import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/timeline_data.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/auth_repository.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/widgets/win_switch.dart';

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
                                    .copyWith(fontWeight: FontWeight.bold,fontSize: 14),
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
                    'assets/images/fifa.png',
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
                                    .copyWith(fontWeight: FontWeight.bold,fontSize: 14),
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
                    '${widget.timelineData.gameType == 'FIFA' ? widget.timelineData.scores['firstPlayerScore'] : 'Nil'}',
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
                        fontWeight: FontWeight.w800, fontSize: 16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.redAccent),
                  SizedBox(
                    width: 5,
                  ),
                  Text('200',style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(Icons.message, color: Colors.blueGrey),
                  SizedBox(
                    width: 5,
                  ),
                  Text('50', style: TextStyle(fontSize:14,color: Theme.of(context).textTheme.headline6.color,),),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.share, color: Colors.blueGrey),
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
