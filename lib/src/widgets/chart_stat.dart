import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartWidget extends StatefulWidget {
  final data;

  const PieChartWidget({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    print('data:${widget.data['pesWins'].length}');
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput
                                      is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(widget.data)),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(
                      color: Colors.green,
                      text: 'Wins',
                      isSquare: true,
                      textColor: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xfff8b250),
                      text: 'Draw',
                      isSquare: true,
                      textColor: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.red,
                      text: 'Lose',
                      isSquare: true,
                      textColor: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(data) {
    int fifaWinsTotal = data['fifaWins'].length;
    int pesWinsTotal = data['pesWins'].length;
    int pesLoseTotal = data['pesLoses'].length;
    int fifaLoseTotal = data['fifaLoses'].length;
    int total = data['total'];

    var drawTotal =
        total - (fifaWinsTotal + pesWinsTotal + pesLoseTotal + fifaLoseTotal);

    var winsPercentage =
        (((fifaWinsTotal + pesWinsTotal) / total) * 100).round();
    var losePercentage =
        (((fifaLoseTotal + pesLoseTotal) / total) * 100).round();
    var drawPercentage = ((drawTotal / total) * 100).round();

    print(
        'fifaWins:$fifaWinsTotal;pesWinsTotal:$pesWinsTotal;pesLoseTotal$pesLoseTotal;fifaLoseTotal:$fifaLoseTotal;total$total;drawTotal$drawTotal');

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: (pesWinsTotal + fifaWinsTotal).toDouble(),
            title: winsPercentage > 0 ? '$winsPercentage%' : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: drawTotal.toDouble(),
            title: drawPercentage > 0 ? '$drawPercentage%' : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: (pesLoseTotal + fifaLoseTotal).toDouble(),
            title: losePercentage > 0 ? '$losePercentage%' : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
