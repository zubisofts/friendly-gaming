// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StatisticsItem extends StatefulWidget {
  final data;

  const StatisticsItem({Key key, this.data}) : super(key: key);

  @override
  _StatisticsItemState createState() => _StatisticsItemState();
}

class _StatisticsItemState extends State<StatisticsItem> {
  var fifaWinsTotal,
      pesWinsTotal,
      pesLoseTotal,
      fifaLoseTotal,
      total,
      drawTotal,
      pesTotal,
      fifaTotal;

  @override
  void initState() {
    fifaWinsTotal = widget.data['fifaWins'].length;
    pesWinsTotal = widget.data['pesWins'].length;
    pesLoseTotal = widget.data['pesLoses'].length;
    fifaLoseTotal = widget.data['fifaLoses'].length;
    pesTotal = widget.data['pesTotal'];
    fifaTotal = widget.data['fifaTotal'];
    total = widget.data['total'];

    drawTotal =
        total - (fifaWinsTotal + pesWinsTotal + pesLoseTotal + fifaLoseTotal);

    super.initState();
  }

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
                            'Draw',
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
                            '$fifaWinsTotal',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '$fifaLoseTotal',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '${fifaTotal - (fifaLoseTotal + fifaWinsTotal)}',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '$fifaTotal',
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
                            '$pesWinsTotal',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '$pesLoseTotal',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '${pesTotal - (pesLoseTotal + pesWinsTotal)}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '$pesTotal',
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
