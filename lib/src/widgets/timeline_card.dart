import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/timeline_data.dart';
import 'package:friendly_gaming/src/widgets/win_switch.dart';

// ignore: must_be_immutable
class TimelineCard extends StatefulWidget {
  TimelineData timelineData;

  TimelineCard({this.timelineData});

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/${widget.timelineData.firstPlayerImageUrl}'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.timelineData.firstPlayer,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/fifa.png',
                    width: 40,
                    height: 100,
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/${widget.timelineData.secondPlayerImageUrl}'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.timelineData.secondPlayer,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
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
                    '${widget.timelineData.firstPlayerScore}',
                    style: TextStyle(
                        color: widget.timelineData.firstPlayerScore >
                                widget.timelineData.secondPlayerScore
                            ? Colors.green
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    'Score',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '${widget.timelineData.secondPlayerScore}',
                    style: TextStyle(
                        color: widget.timelineData.secondPlayerScore >
                                widget.timelineData.firstPlayerScore
                            ? Colors.green
                            : Colors.black,
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
              firstPlayerScore: widget.timelineData.firstPlayerScore,
              secondPlayerScore: widget.timelineData.secondPlayerScore),
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
                  Text('${widget.timelineData.likes}'),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(Icons.message, color: Colors.blueGrey),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${widget.timelineData.comments}'),
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
