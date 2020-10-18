import 'package:flutter/material.dart';

class ScoreSelector extends StatefulWidget {
  final Function(int) onSelect;

  ScoreSelector({this.onSelect});

  @override
  _ScoreSelectorState createState() => _ScoreSelectorState();
}

class _ScoreSelectorState extends State<ScoreSelector> {
  int number;
  TextEditingController textEditingController;

  @override
  void initState() {
    number = 0;
    textEditingController = TextEditingController(text: '$number');
    textEditingController.addListener(() {
      widget.onSelect(int.parse(textEditingController.text));
    });
    super.initState();
  }

  void increaseNumber() => setState(() {
        number = number + 1;
        textEditingController.text = '$number';
      });

  void decreaseNumber() => setState(() {
        number = number != 0 ? number - 1 : 0;
        textEditingController.text = '$number';
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: decreaseNumber,
              child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 16,
                    color: Colors.white,
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //   width: 30,
              // height: 30,
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLines: 1,
                maxLength: 3,
                buildCounter:
                    (context, {currentLength, isFocused, maxLength}) => null,
                maxLengthEnforced: true,
                style: TextStyle(fontSize: 30, color: Colors.blue),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: increaseNumber,
              child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 16,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
