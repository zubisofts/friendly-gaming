import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  String id;
  String firstPlayerId;
  String secondPlayerId;
  Map<String, int> scores;
  String gameType;
  List<String> images;
  DateTime date;
  Post({
    this.id,
    this.firstPlayerId,
    this.secondPlayerId,
    this.scores,
    this.gameType,
    this.images,
    this.date,
  });


  Post copyWith({
    String id,
    String firstPlayerId,
    String secondPlayerId,
    Map<String, int> scores,
    String gameType,
    List<String> images,
    DateTime date,
  }) {
    return Post(
      id: id ?? this.id,
      firstPlayerId: firstPlayerId ?? this.firstPlayerId,
      secondPlayerId: secondPlayerId ?? this.secondPlayerId,
      scores: scores ?? this.scores,
      gameType: gameType ?? this.gameType,
      images: images ?? this.images,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstPlayerId': firstPlayerId,
      'secondPlayerId': secondPlayerId,
      'scores': scores,
      'gameType': gameType,
      'images': images,
      'date': date?.millisecondsSinceEpoch,
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
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, firstPlayerId: $firstPlayerId, secondPlayerId: $secondPlayerId, scores: $scores, gameType: $gameType, images: $images, date: $date)';
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
      listEquals(o.images, images) &&
      o.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstPlayerId.hashCode ^
      secondPlayerId.hashCode ^
      scores.hashCode ^
      gameType.hashCode ^
      images.hashCode ^
      date.hashCode;
  }
}
