import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:friendly_gaming/src/model/comment.dart';
import 'package:friendly_gaming/src/model/like.dart';

import 'package:http/http.dart' as http;

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class MessagingRepository {
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
            'uid': uid
          }));
      return res.body;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<Comment>> comments(String postId) {
    try {
      return FirebaseFirestore.instance
          .collection("post_comments")
          .doc(postId)
          .collection('comments')
          .where('postId', isEqualTo: '$postId')
          .orderBy('time', descending: true)
          .snapshots()
          .asyncMap((snapshots) async {
        return await convertSnapshots(snapshots);
      });
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }

    return null;
  }

  Future<String> addComent(Comment comment) async {
    try {
      var documentReference = await FirebaseFirestore.instance
          .collection('post_comments')
          .doc(comment.postId)
          .collection('comments')
          .add(comment.toMap());
      return documentReference.id;
    } on FirebaseException catch (e) {
      print('Add Comment Error:${e.message}');
      return null;
    }
  }

  Future<void> deleteComent(String postId, String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('post_comments')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();
    } on FirebaseException catch (e) {
      print('Add Comment Error:${e.message}');
      return null;
    }
  }

  Stream<List<Like>> likes(String postId) {
    try {
      return FirebaseFirestore.instance
          .collection("post_likes")
          .doc(postId)
          .collection('likes')
          .where('postId', isEqualTo: '$postId')
          .snapshots()
          .asyncMap((snapshots) async {
        return await convertLikeSnapshots(snapshots);
      });
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }

    return null;
  }

  Future<String> addLike(Like like) async {
    try {
      var documentReference = await FirebaseFirestore.instance
          .collection('post_likes')
          .doc(like.postId)
          .collection('likes')
          .add(like.toMap());
      return documentReference.id;
    } on FirebaseException catch (e) {
      print('Add Comment Error:${e.message}');
      return null;
    }
  }

  Future<void> unLike(String likeId, String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('post_likes')
          .doc(postId)
          .collection('likes')
          .doc(likeId)
          .delete();
    } on FirebaseException catch (e) {
      print('Add Comment Error:${e.message}');
      return null;
    }
  }

  Future<List<Comment>> convertSnapshots(QuerySnapshot snapshots) async {
    return snapshots.docs.map((doc) {
      return Comment.fromMap(doc.data());
    }).toList();
  }

  Future<List<Like>> convertLikeSnapshots(QuerySnapshot snapshots) async {
    return snapshots.docs.map((doc) {
      return Like.fromMap(doc.data());
    }).toList();
  }
}
