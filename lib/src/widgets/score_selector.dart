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
    number = 5;
    textEditingController = TextEditingController(text: '$number');
    super.initState();
  }

  void increaseNumber() => setState(() {
        number = number < 10 ? number + 1 : number;
        textEditingController.text = '$number';
      });

  void decreaseNumber() => setState(() {
        number = number > 0 ? number - 1 : number;
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
                  height: 24,
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
                maxLength: 2,
                buildCounter:
                    (context, {currentLength, isFocused, maxLength}) => null,
                maxLengthEnforced: true,
                style: TextStyle(fontSize: 40, color: Colors.blue),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    textEditingController.text=int.parse(value) > 10 ? '10' : value;
                    // number = int.parse(value);
                    widget.onSelect(int.parse(value));
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: increaseNumber,
              child: Container(
                  height: 24,
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
