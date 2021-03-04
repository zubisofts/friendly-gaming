import 'dart:convert';

class Like {
  String id;
  String postId;
  String userId;
  int time;
  Like({
    this.id,
    this.postId,
    this.userId,
    this.time,
  });

  Like copyWith({
    String id,
    String postId,
    String userId,
    int time,
  }) {
    return Like(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'time': time,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Like(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Like(id: $id, postId: $postId, userId: $userId, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Like &&
      o.id == id &&
      o.postId == postId &&
      o.userId == userId &&
      o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      postId.hashCode ^
      userId.hashCode ^
      time.hashCode;
  }
}
