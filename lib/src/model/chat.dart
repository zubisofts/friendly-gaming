import 'package:friendly_gaming/src/datasource/chat_data.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:meta/meta.dart';

class Chat {
  String id;
  Message lastMessage;
  int timestamp;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Chat({
    @required this.id,
    @required this.lastMessage,
    @required this.timestamp,
  });

  Chat copyWith({
    String id,
    Message lastMessage,
    int timestamp,
  }) {
    return new Chat(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'Chat{id: $id, lastMessage: ${lastMessage.toMap()}, timestamp: $timestamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          lastMessage == other.lastMessage &&
          timestamp == other.timestamp);

  @override
  int get hashCode => id.hashCode ^ lastMessage.hashCode ^ timestamp.hashCode;

  factory Chat.fromMap(Map<String, dynamic> map) {
    return new Chat(
      id: map['id'] as String,
      lastMessage: Message.fromMap(map['lastMessage']),
      timestamp: map['timestamp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'lastMessage': this.lastMessage.toMap(),
      'timestamp': this.timestamp,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
