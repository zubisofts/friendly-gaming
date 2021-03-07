import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  String id;
  String firstPlayerId;
  String secondPlayerId;
  Map<String, int> scores;
  String gameType;
  String status;
  List<String> updates;
  DateTime date;
  Post({
    this.id,
    this.firstPlayerId,
    this.secondPlayerId,
    this.scores,
    this.gameType,
    this.status,
    this.updates,
    this.date,
  });

  Post copyWith({
    String id,
    String firstPlayerId,
    String secondPlayerId,
    Map<String, int> scores,
    String gameType,
    String status,
    List<String> updates,
    DateTime date,
  }) {
    return Post(
      id: id ?? this.id,
      firstPlayerId: firstPlayerId ?? this.firstPlayerId,
      secondPlayerId: secondPlayerId ?? this.secondPlayerId,
      scores: scores ?? this.scores,
      gameType: gameType ?? this.gameType,
      status: status ?? this.status,
      updates: updates ?? this.updates,
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
      'status': status,
      'updates': updates,
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
      status: map['status'],
      updates: List<String>.from(map['updates']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, firstPlayerId: $firstPlayerId, secondPlayerId: $secondPlayerId, scores: $scores, gameType: $gameType, status: $status, updates: $updates, date: $date)';
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
      o.status == status &&
      listEquals(o.updates, updates) &&
      o.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstPlayerId.hashCode ^
      secondPlayerId.hashCode ^
      scores.hashCode ^
      gameType.hashCode ^
      status.hashCode ^
      updates.hashCode ^
      date.hashCode;
  }
}
