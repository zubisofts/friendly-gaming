import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:http/http.dart' as http;

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class MessagingRepository{

RtcEngine _engine;

Future<String> generateToken(
      String appId, String cert, String channel, int uid) async {
    try {
      var res = await http.post('https://agora-token-gen.herokuapp.com/token',
          headers: {'Content-type': 'application/json'},
          body: JsonEncoder().convert({
            'appId': '$appId',
            'appCertificate': cert,
            'channelName': '$channel',
            'uid': '$uid'
          }));
      return res.body;
    } catch (e) {
      print(e);
      return null;
    }
  }
}