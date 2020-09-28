import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/widgets/statistics_item.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Statistics', style: TextStyle(color: Colors.black)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  StatisticsItem(),
                  SizedBox(height: 16.0,),
                  StatisticsItem(),
                  SizedBox(height: 16.0,),
                  StatisticsItem(),
                  SizedBox(height: 16.0,),
                  StatisticsItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
