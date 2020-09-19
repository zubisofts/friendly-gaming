import 'package:flutter/material.dart';

class WinSwitch extends StatefulWidget {
  int firstPlayerScore;
  int secondPlayerScore;

  WinSwitch({this.firstPlayerScore, this.secondPlayerScore});

  @override
  _WinSwitchState createState() => _WinSwitchState();
}

class _WinSwitchState extends State<WinSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: widget.firstPlayerScore > widget.secondPlayerScore
                        ? Colors.green
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    widget.firstPlayerScore > widget.secondPlayerScore
                        ? 'WIN'
                        : 'LOSE',
                    style: TextStyle(
                        color: widget.firstPlayerScore > widget.secondPlayerScore
                        ? Colors.white
                        : Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: widget.secondPlayerScore > widget.firstPlayerScore
                        ? Colors.green
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    widget.secondPlayerScore > widget.firstPlayerScore
                        ? 'WIN'
                        : 'LOSE',
                    style: TextStyle(color: widget.secondPlayerScore > widget.firstPlayerScore
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
