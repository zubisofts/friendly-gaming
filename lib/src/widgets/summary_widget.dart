import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final firstPlayerData;
  final secondPlayerData;

  const SummaryWidget(this.firstPlayerData, this.secondPlayerData);

  @override
  Widget build(BuildContext context) {
    int p1FifaWinsTotal = firstPlayerData['fifaWins'].length;
    int p1PesWinsTotal = firstPlayerData['pesWins'].length;
    int p1PesLoseTotal = firstPlayerData['pesLoses'].length;
    int p1FifaLoseTotal = firstPlayerData['fifaLoses'].length;
    int p1Total = firstPlayerData['total'];

    var p1DrawTotal = p1Total -
        (p1FifaWinsTotal +
            p1PesWinsTotal +
            p1PesLoseTotal +
            p1FifaLoseTotal);

    var p1WinsPercentage =
        (((p1FifaWinsTotal + p1PesWinsTotal) / p1Total) * 100).round();
    var p1LosePercentage =
        (((p1FifaLoseTotal + p1PesLoseTotal) / p1Total) * 100).round();
    var p1DrawPercentage = ((p1DrawTotal / p1Total) * 100).round();

    // ******************************************************************************************
    int p2FifaWinsTotal = secondPlayerData['fifaWins'].length;
    int p2PesWinsTotal = secondPlayerData['pesWins'].length;
    int p2PesLoseTotal = secondPlayerData['pesLoses'].length;
    int p2FifaLoseTotal = secondPlayerData['fifaLoses'].length;
    int p2Total = secondPlayerData['total'];

    var p2DrawTotal = p2Total -
        (p2FifaWinsTotal +
            p2PesWinsTotal +
            p2PesLoseTotal +
            p2FifaLoseTotal);

    var p2WinsPercentage =
        (((p2FifaWinsTotal + p2PesWinsTotal) / p2Total) * 100).round();
    var p2LosePercentage =
        (((p2FifaLoseTotal + p2PesLoseTotal) / p2Total) * 100).round();
    var p2DrawPercentage = ((p2DrawTotal / p2Total) * 100).round();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Total Games Played',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p1Total',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Total Games Played',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p2Total',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Win',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p1WinsPercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Win',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p2WinsPercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Lose',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p1LosePercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Lose',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p2LosePercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Draw',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p1DrawPercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Draw',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text('$p2DrawPercentage%',
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
