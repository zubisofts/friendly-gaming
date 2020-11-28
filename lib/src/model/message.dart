import 'dart:convert';

class Message {
  String id;
  String senderId;
  String message;
  int timestamp;
  String imageFile;
  String audioFile;
  String mediaType;
  Message({
    this.id,
    this.senderId,
    this.message,
    this.timestamp,
    this.imageFile,
    this.audioFile,
    this.mediaType,
  });

  Message copyWith({
    String id,
    String senderId,
    String message,
    int timestamp,
    String imageFile,
    String audioFile,
    String mediaType,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      imageFile: imageFile ?? this.imageFile,
      audioFile: audioFile ?? this.audioFile,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
      'imageFile': imageFile,
      'audioFile': audioFile,
      'mediaType': mediaType,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      id: map['id'],
      senderId: map['senderId'],
      message: map['message'],
      timestamp: map['timestamp'],
      imageFile: map['imageFile'],
      audioFile: map['audioFile'],
      mediaType: map['mediaType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, message: $message, timestamp: $timestamp, imageFile: $imageFile, audioFile: $audioFile, mediaType: $mediaType)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message &&
        o.id == id &&
        o.senderId == senderId &&
        o.message == message &&
        o.timestamp == timestamp &&
        o.imageFile == imageFile &&
        o.audioFile == audioFile &&
        o.mediaType == mediaType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        message.hashCode ^
        timestamp.hashCode ^
        imageFile.hashCode ^
        audioFile.hashCode ^
        mediaType.hashCode;
  }
}
