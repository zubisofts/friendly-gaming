import 'dart:convert';

class Comment {
  String id;
  String userId;
  String postId;
  String comment;
  int time;
  Comment({
    this.id,
    this.userId,
    this.postId,
    this.comment,
    this.time,
  });

  Comment copyWith({
    String id,
    String userId,
    String postId,
    String comment,
    int time,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      comment: comment ?? this.comment,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'comment': comment,
      'time': time,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Comment(
      id: map['id'],
      userId: map['userId'],
      postId: map['postId'],
      comment: map['comment'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, userId: $userId, postId: $postId, comment: $comment, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Comment &&
      o.id == id &&
      o.userId == userId &&
      o.postId == postId &&
      o.comment == comment &&
      o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      postId.hashCode ^
      comment.hashCode ^
      time.hashCode;
  }
}
