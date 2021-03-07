import 'dart:convert';

enum RequestStatus { Pending, Accepted, Declined }

class Request {
  String requestId;
  String senderId;
  String receiverId;
  int date;
  String requestType;
  String status;
  String gameId;
  Request({
    this.requestId,
    this.senderId,
    this.receiverId,
    this.date,
    this.requestType,
    this.status,
    this.gameId,
  });

  Request copyWith({
    String requestId,
    String senderId,
    String receiverId,
    int date,
    String requestType,
    String status,
    String gameId,
  }) {
    return Request(
      requestId: requestId ?? this.requestId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      date: date ?? this.date,
      requestType: requestType ?? this.requestType,
      status: status ?? this.status,
      gameId: gameId ?? this.gameId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'senderId': senderId,
      'receiverId': receiverId,
      'date': date,
      'requestType': requestType,
      'status': status,
      'gameId': gameId,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Request(
      requestId: map['requestId'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      date: map['date'],
      requestType: map['requestType'],
      status: map['status'],
      gameId: map['gameId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(requestId: $requestId, senderId: $senderId, receiverId: $receiverId, date: $date, requestType: $requestType, status: $status, gameId: $gameId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Request &&
        o.requestId == requestId &&
        o.senderId == senderId &&
        o.receiverId == receiverId &&
        o.date == date &&
        o.requestType == requestType &&
        o.status == status &&
        o.gameId == gameId;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        date.hashCode ^
        requestType.hashCode ^
        status.hashCode ^
        gameId.hashCode;
  }
}
