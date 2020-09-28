import 'package:flutter/material.dart';

class GameSelector extends StatefulWidget {
  final Function(String) onGameSelected;

  GameSelector({this.onGameSelected});

  @override
  _GameSelectorState createState() => _GameSelectorState();
}

class _GameSelectorState extends State<GameSelector> {
  String selectedGame;

  @override
  void initState() {
    selectedGame = 'FIFA';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                InkWell(
                    onTap: () => setState(() {
                          selectedGame = 'FIFA';
                          widget.onGameSelected(selectedGame);
                        }),
                    child: _buildGameWidget(
                        title: 'FIFA', isSelected: 'FIFA' == selectedGame)),
                InkWell(
                    onTap: () => setState(() {
                          selectedGame = 'CRICKET';
                          widget.onGameSelected(selectedGame);
                        }),
                    child: _buildGameWidget(
                        title: 'CRICKET',
                        isSelected: 'CRICKET' == selectedGame)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                InkWell(
                    onTap: () => setState(() {
                          selectedGame = 'COD';
                          widget.onGameSelected(selectedGame);
                        }),
                    child:
                        _buildGameWidget(title: 'COD', isSelected: 'COD' == selectedGame)),
                InkWell(
                    onTap: () => setState(() {
                          selectedGame = 'DOTA 2';
                          widget.onGameSelected(selectedGame);
                        }),
                    child: _buildGameWidget(
                        title: 'DOTA 2', isSelected: 'DOTA 2' == selectedGame)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGameWidget({String title, bool isSelected}) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.fromBorderSide(BorderSide(
            width: 1, color: isSelected ? Colors.blue : Colors.grey)),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutQuart,
      child: Center(
        child: Text(title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.grey)),
      ),
    );
  }
}
