import 'package:flutter/material.dart';

enum GameType { FIFA, CRICKET, COD, DOTA2 }

class Post {
  String id;
  String firstPlayerId;
  String secondPlayerId;
  Score score;
  GameType gameType;
  List<String> images;

  Post(
      {this.id,
      this.firstPlayerId,
      this.secondPlayerId,
      this.score,
      this.gameType,
      this.images});

      
}

abstract class Score {
  Map<String, int> getScore();
}

class FifaScore extends Score {
  int playerOneScore;
  int playerTwoScore;

  FifaScore({@required this.playerOneScore, @required this.playerTwoScore});

  @override
  Map<String, int> getScore() {
    return {"playerOneScore": playerOneScore, "playerTwoScore": playerTwoScore};
  }
}

class CricketScore extends Score {
  int run1;
  int run2;
  int out1;
  int out2;

  CricketScore(
      {@required this.run1,
      @required this.run2,
      @required this.out1,
      @required this.out2});

  @override
  Map<String, int> getScore() {
    return {"run1": run1, "run2": run2, "out1": out1, "out2": out2};
  }
}
