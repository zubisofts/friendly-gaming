import 'dart:convert';

class Call {
  String callerId;
  String recieverId;
  bool isActive;
  bool incoming;
  int timeStamp;
  String channel;
  String token;
  Call({
    this.callerId,
    this.recieverId,
    this.isActive,
    this.incoming,
    this.timeStamp,
    this.channel,
    this.token,
  });

  Call copyWith({
    String callerId,
    String recieverId,
    bool isActive,
    bool incoming,
    int timeStamp,
    String channel,
    String token,
  }) {
    return Call(
      callerId: callerId ?? this.callerId,
      recieverId: recieverId ?? this.recieverId,
      isActive: isActive ?? this.isActive,
      incoming: incoming ?? this.incoming,
      timeStamp: timeStamp ?? this.timeStamp,
      channel: channel ?? this.channel,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'callerId': callerId,
      'recieverId': recieverId,
      'isActive': isActive,
      'incoming': incoming,
      'timeStamp': timeStamp,
      'channel': channel,
      'token': token,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Call(
      callerId: map['callerId'],
      recieverId: map['recieverId'],
      isActive: map['isActive'],
      incoming: map['incoming'],
      timeStamp: map['timeStamp'],
      channel: map['channel'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Call(callerId: $callerId, recieverId: $recieverId, isActive: $isActive, incoming: $incoming, timeStamp: $timeStamp, channel: $channel, token: $token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Call &&
        o.callerId == callerId &&
        o.recieverId == recieverId &&
        o.isActive == isActive &&
        o.incoming == incoming &&
        o.timeStamp == timeStamp &&
        o.channel == channel &&
        o.token == token;
  }

  @override
  int get hashCode {
    return callerId.hashCode ^
        recieverId.hashCode ^
        isActive.hashCode ^
        incoming.hashCode ^
        timeStamp.hashCode ^
        channel.hashCode ^
        token.hashCode;
  }
}
