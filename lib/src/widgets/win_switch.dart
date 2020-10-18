import 'package:flutter/material.dart';

class WinSwitch extends StatefulWidget {
  final int firstPlayerScore;
  final int secondPlayerScore;

  WinSwitch({this.firstPlayerScore, this.secondPlayerScore});

  @override
  _WinSwitchState createState() => _WinSwitchState();
}

class _WinSwitchState extends State<WinSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.firstPlayerScore==widget.secondPlayerScore?Colors.green:Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: (widget.firstPlayerScore >
                                    widget.secondPlayerScore ||
                                widget.firstPlayerScore ==
                                    widget.secondPlayerScore)
                            ? Colors.green
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                     (widget.firstPlayerScore >
                                    widget.secondPlayerScore ||
                                widget.firstPlayerScore ==
                                    widget.secondPlayerScore)
                            ? 'WIN'
                            : 'LOSE',
                    style: TextStyle(
                        color: (widget.firstPlayerScore >
                                    widget.secondPlayerScore ||
                                widget.firstPlayerScore ==
                                    widget.secondPlayerScore)
                            ? Colors.white
                            : Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
              widget.firstPlayerScore==widget.secondPlayerScore?Icon(Icons.compare_arrows,color:Colors.white):SizedBox.shrink(),
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: (widget.secondPlayerScore >
                                    widget.firstPlayerScore ||
                                widget.firstPlayerScore ==
                                    widget.secondPlayerScore)
                            ? Colors.green
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    (widget.secondPlayerScore >
                                    widget.firstPlayerScore ||
                                widget.secondPlayerScore ==
                                    widget.firstPlayerScore)
                            ? 'WIN'
                            : 'LOSE',
                    style: TextStyle(color: (widget.secondPlayerScore >
                                    widget.firstPlayerScore ||
                                widget.secondPlayerScore ==
                                    widget.firstPlayerScore)
                            ? Colors.white
                            : Colors.black,fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
