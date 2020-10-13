import 'dart:convert';

import 'package:flutter/foundation.dart';

enum GameType { FIFA, CRICKET, COD, DOTA2 }

class Post {
  String id;
  String firstPlayerId;
  String secondPlayerId;
  Map<String, int> scores;
  GameType gameType;
  List<String> images;

  Post({
    this.id,
    this.firstPlayerId,
    this.secondPlayerId,
    this.scores,
    this.gameType,
    this.images,
  });

  Post copyWith({
    String id,
    String firstPlayerId,
    String secondPlayerId,
    Map<String, int> scores,
    GameType gameType,
    List<String> images,
  }) {
    return Post(
      id: id ?? this.id,
      firstPlayerId: firstPlayerId ?? this.firstPlayerId,
      secondPlayerId: secondPlayerId ?? this.secondPlayerId,
      scores: scores ?? this.scores,
      gameType: gameType ?? this.gameType,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstPlayerId': firstPlayerId,
      'secondPlayerId': secondPlayerId,
      'scores': scores,
      'gameType': gameType.toString(),
      'images': images,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      id: map['id'],
      firstPlayerId: map['firstPlayerId'],
      secondPlayerId: map['secondPlayerId'],
      scores: Map<String, int>.from(map['scores']),
      gameType: map['gameType'],
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, firstPlayerId: $firstPlayerId, secondPlayerId: $secondPlayerId, scores: $scores, gameType: $gameType, images: $images)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.id == id &&
        o.firstPlayerId == firstPlayerId &&
        o.secondPlayerId == secondPlayerId &&
        mapEquals(o.scores, scores) &&
        o.gameType == gameType &&
        listEquals(o.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstPlayerId.hashCode ^
        secondPlayerId.hashCode ^
        scores.hashCode ^
        gameType.hashCode ^
        images.hashCode;
  }
}
