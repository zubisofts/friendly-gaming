import 'package:flutter/material.dart';

class IncomingCallScreen extends StatefulWidget {
  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Video Call', style: TextStyle(fontSize: 16,
                    color: Theme.of(context).textTheme.headline6.color)),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Theme.of(context).iconTheme.color),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueGrey,
                    ),
                    SizedBox(height: 16),
                    Text('Anyanwu Nzubechi', style: TextStyle(fontSize: 18,
                     color: Theme.of(context).textTheme.headline6.color,fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Calling', style: TextStyle(fontSize: 16,
                    color: Theme.of(context).textTheme.headline6.color)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.call_end, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 32.0),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.call, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
