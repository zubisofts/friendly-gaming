// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StatisticsItem extends StatelessWidget {
  final data;

  const StatisticsItem({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).cardColor,
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
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '10',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
                            'PES',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
    );
  }
}
