import 'package:flutter/material.dart';

class SampleUIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {},
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: CircleAvatar(
      //         radius: 18.0,
      //         backgroundImage: AssetImage('assets/images/img4.png'),
      //       ),
      //     )
      //   ],
      //   title: Text('My Title'),
      // ),
      // drawer: Drawer(
      //   child: DrawerHeader(
      //     child: Container(height: 200, color: Colors.green),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(height: 45.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Sumiya',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage: AssetImage('assets/images/img4.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.sim_card),
                        Text('VISA',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 24.0),
                    Text('4562112245957852',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
