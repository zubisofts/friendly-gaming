// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StatisticsItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32.0),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 8.0),
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                            BorderSide(width: 3, color: Colors.blue)),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '1st',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  // DottedBorder(
                  //   strokeWidth: 2,
                  //   child: Container(
                  //     // width: 0,
                  //     height: 130,
                  //   ),
                  //   color: Colors.grey,
                  // )
                ],
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Hamand',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      // ******************Second Row****************
                      // *********************************************
                      Table(
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: Text(
                                'Games Played',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Win',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Lose',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Played',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),

                          // ****************************************
                          // ***********************************
                          TableRow(children: [
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Text(
                                'FIFA',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '12',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          // ****************************************
                          // ***********************************
                          TableRow(children: [
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Text(
                                'Cricket',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '5',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                '6',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ])
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 80.0,
            top: -24.0,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/img2.jpg'),
              radius: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
