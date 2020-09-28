import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/timeline_data.dart';
import 'package:friendly_gaming/src/widgets/timeline_card.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
              children: TimelineData.getTimelines()
                  .map((timelineData) => TimelineCard(
                        timelineData: timelineData,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
