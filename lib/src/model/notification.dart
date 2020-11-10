import 'package:meta/meta.dart';

enum NotificationType {
  Challenge,
}

class FGNotification {
  String notificationId;
  String title;
  String description;
  String actionIntentId;
  String type;
  bool read;
  int time;

  FGNotification({
    this.notificationId,
    @required this.title,
    @required this.description,
    @required this.actionIntentId,
    @required this.type,
    @required this.read,
    @required this.time,
  });

  FGNotification copyWith({
    String notificationId,
    String title,
    String description,
    String actionIntentId,
    String type,
    bool read,
    int time,
  }) {
    return new FGNotification(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      description: description ?? this.description,
      actionIntentId: actionIntentId ?? this.actionIntentId,
      type: type ?? this.type,
      read: read ?? this.read,
      time: time ?? this.time,
    );
  }

  @override
  String toString() {
    return 'FGNotification{notificationId: $notificationId, title: $title, description: $description, actionIntentId: $actionIntentId, type: $type, read: $read, time: $time}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FGNotification &&
          runtimeType == other.runtimeType &&
          notificationId == other.notificationId &&
          title == other.title &&
          description == other.description &&
          actionIntentId == other.actionIntentId &&
          type == other.type &&
          read == other.read &&
          time == other.time);

  @override
  int get hashCode =>
      notificationId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      actionIntentId.hashCode ^
      type.hashCode ^
      read.hashCode ^
      time.hashCode;

  factory FGNotification.fromMap(Map<String, dynamic> map) {
    return new FGNotification(
      notificationId: map['notificationId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      actionIntentId: map['actionIntentId'] as String,
      type: map['type'] as String,
      read: map['read'] as bool,
      time: map['time'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'notificationId': this.notificationId,
      'title': this.title,
      'description': this.description,
      'actionIntentId': this.actionIntentId,
      'type': this.type,
      'read': this.read,
      'time': this.time,
    } as Map<String, dynamic>;
  }

}
