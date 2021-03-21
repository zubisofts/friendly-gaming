import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/call.dart';
import 'package:friendly_gaming/src/model/chat.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:path_provider/path_provider.dart';

class StorageException implements Exception {
  final String message;

  StorageException({this.message});
}

class DataRepository {
  StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<dynamic> saveProfileImage({String uid, File photo}) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}.jpg';

      var file = await FlutterImageCompress.compressAndGetFile(
        photo.absolute.path,
        tempPath,
        quality: 50,
      );
      final StorageUploadTask uploadTask = _storageReference
          .child('profile_images')
          .child('$uid.jpg')
          .putFile(file);
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      String url = await snapshot.ref.getDownloadURL();
      print(
          '************************************uploaded*************************');
      // print(url);
      return url;
    } catch (e) {
      print(e);
      // throw StorageException(message: e.toString());
    }
  }

  Future<dynamic> savePostImage(String postId, String name, File photo) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}.jpg';

      var file = await FlutterImageCompress.compressAndGetFile(
        photo.absolute.path,
        tempPath,
        quality: 50,
      );
      final StorageUploadTask uploadTask = _storageReference
          .child('post_images')
          .child('$postId')
          .child('$name.jpg')
          .putFile(file);
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      String url = await snapshot.ref.getDownloadURL();
      print(
          '************************************uploaded*************************');
      // print(url);
      return url;
    } catch (e) {
      print(e);
      // throw StorageException(message: e.toString());
    }
  }

  Future<User> user(String uid) async {
    try {
      var documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return User.fromJson(documentSnapshot.data());
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Stream<User> userDetails(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((doc) => User.fromJson(doc.data()));
  }

  Future<List<User>> users({String uid}) async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      return querySnapshot.docs
          .map((doc) => User.fromJson(doc.data()))
          .where((user) => uid != user.id)
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<User>> get allUsers async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      return querySnapshot.docs
          .map((doc) => User.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<User>> searchUsers(String query, {String uid}) async {
    print(query);
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      // print(querySnapshot.docs.length);
      return querySnapshot.docs
          .map((doc) => User.fromJson(doc.data()))
          .where(
              (user) => user.name.toLowerCase().startsWith(query.toLowerCase()))
          .where((user) => uid != user.id)
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> savePost(Post post, Request request) async {
    Map<String, dynamic> update = {};
    try {
      var documentReference = await FirebaseFirestore.instance
          .collection("posts")
          .add(post.toMap());
      update['id'] = documentReference.id;
      request.gameId = documentReference.id;
      documentReference.update(update).then((value) => {sendRequest(request)});

      return documentReference.id;
    } on FirebaseException catch (e) {
      print(e.message);
    }

    return null;
  }

  Stream<List<Post>> posts({page}) {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          // .where('status', isEqualTo: 'completed')
          .orderBy('date', descending: true)
          // .startAt(page)
          // .limit(5)
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

  Stream<List<Post>> completedGames({page}) {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          .where('status', isEqualTo: 'completed')
          .orderBy('date', descending: true)
          // .startAt(page)
          // .limit(5)
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

  Future<List<Post>> getGames(String uid) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where('status', isEqualTo: 'completed')
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((post) => Post.fromMap(post.data()))
          .where(
              (post) => post.firstPlayerId == uid || post.secondPlayerId == uid)
          .toList();
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }

    return null;
  }

  Future<Map<String, dynamic>> getMutiPlayesGames(
      String playerOneId, String playerTwoId) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where('status', isEqualTo: 'completed')
          .orderBy('date', descending: true)
          .get();

      var p1games = snapshot.docs
          .map((post) => Post.fromMap(post.data()))
          .where((post) =>
              post.firstPlayerId == playerOneId ||
              post.secondPlayerId == playerOneId)
          .toList();

      var p2Games = snapshot.docs
          .map((post) => Post.fromMap(post.data()))
          .where((post) =>
              post.firstPlayerId == playerTwoId ||
              post.secondPlayerId == playerTwoId)
          .toList();

      return Map.of(
          {'firstPlayerGames': p1games, 'secondPlayerGames': p2Games});
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }

    return null;
  }

  Future<bool> editPost(Map<String, dynamic> data, String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(data);
      return true;
    } on FirebaseException catch (e) {
      print('Error updating scores:${e.message}');
    }
    return false;
  }

  Stream<List<Post>> get fetchMyActiveGames {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          .orderBy('date', descending: true)
          .snapshots()
          .asyncMap((snapshots) async {
        return snapshots.docs
            .map((doc) {
              return Post.fromMap(doc.data());
            })
            .where((post) =>
                (post.firstPlayerId == AuthBloc.uid ||
                    post.secondPlayerId == AuthBloc.uid) &&
                post.status == 'active')
            .toList();
      });
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }

    return null;
  }

  // Requests
  Future<String> sendRequest(Request request) async {
    try {
      print('***Sending Request**');
      var documentReference = await FirebaseFirestore.instance
          .collection("requests")
          .doc(request.receiverId)
          .collection('game_requests')
          .add(request.toMap());
      Map<String, String> update = {'requestId': documentReference.id};
      documentReference.update(update);

      User sender = await user(request.senderId);

      FGNotification notification = FGNotification(
          title: 'New Challenge',
          description: 'You received a new game challenge from ${sender.name}',
          actionIntentId: documentReference.id,
          type: NotificationType.Challenge.toString().split('.').last,
          read: false,
          time: DateTime.now().millisecondsSinceEpoch);
      await sendNotification(notification, request.receiverId);
      return documentReference.id;
      //
    } on FirebaseException catch (ex) {
      return null;
    }
  }

  // Fetch List of requests
  Stream<List<Request>> get requests {
    try {
      return FirebaseFirestore.instance
          .collection("requests")
          .doc(AuthBloc.uid)
          .collection('game_requests')
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => Request.fromMap(doc.data()))
              .toList());
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // Or do other work.
  Future<List<Post>> convertSnapshots(QuerySnapshot snapshots) async {
    return snapshots.docs.map((doc) {
      return Post.fromMap(doc.data());
    }).toList();
  }

  Future<void> sendNotification(
      FGNotification notification, String receiverId) async {
    try {
      var reference = await FirebaseFirestore.instance
          .collection("notifications")
          .doc(receiverId)
          .collection("notifs")
          .add(notification.toMap());
      reference.update({'notificationId': reference.id});
    } on FirebaseException catch (e) {}
  }

  Stream<List<FGNotification>> get notifications {
    return FirebaseFirestore.instance
        .collection("notifications")
        .doc(AuthBloc.uid)
        .collection("notifs")
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => FGNotification.fromMap(doc.data()))
            .toList());
  }

  Stream<Call> get call {
    return FirebaseFirestore.instance
        .collection("user_calls")
        .doc(AuthBloc.uid)
        .collection("calls")
        .doc('call')
        .snapshots()
        .map((doc) => Call.fromMap(doc.data()));
  }

  Future<void> respondToGameRequest(bool accept, Request request) async {
    try {
      if (accept) {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(request.gameId)
            .update({'status': 'active'}).then((value) => {
                  FirebaseFirestore.instance
                      .collection('requests')
                      .doc(AuthBloc.uid)
                      .collection('game_requests')
                      .doc(request.requestId)
                      .delete()
                });
      } else {
        FirebaseFirestore.instance
            .collection('requests')
            .doc(AuthBloc.uid)
            .collection('game_requests')
            .doc(request.requestId)
            .delete();
      }
    } on FirebaseException catch (e) {
      print('Error accepting request$e');
    }
  }

  Future<void> pushCall(Call call) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_calls')
          .doc(call.recieverId)
          .collection('calls')
          .doc('call')
          .set(call.toMap());
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> endCall(Call call) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_calls')
          .doc(call.recieverId)
          .collection('calls')
          .doc('call')
          .update({"isActive": false, "incoming": false});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> sendMessage(Message message, String receiverId) async {
    try {
      var key = AuthBloc.uid.hashCode + receiverId.hashCode;
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('messages')
          .doc('msg_$key')
          .collection('messages')
          .add(message.toMap());
      await docRef.update({'id': docRef.id});
      await addMessageToChats(receiverId, message);
      return docRef.id;
    } on FirebaseException catch (e) {
      print('SendMessageError:$e');
      return null;
    }
  }

  Future<void> addMessageToChats(String recieverId, Message msg) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      batch.set(
          FirebaseFirestore.instance
              .collection('user_chats')
              .doc(AuthBloc.uid)
              .collection('data')
              .doc('${AuthBloc.uid}_$recieverId'),
          Chat(
            id: '',
            timestamp: msg.timestamp,
            lastMessage: msg,
          ).toMap());

      batch.update(
          FirebaseFirestore.instance
              .collection('user_chats')
              .doc(AuthBloc.uid)
              .collection('data')
              .doc('${AuthBloc.uid}_$recieverId'),
          {'id': recieverId});

      batch.set(
          FirebaseFirestore.instance
              .collection('user_chats')
              .doc(recieverId)
              .collection('data')
              .doc('${recieverId}_${AuthBloc.uid}'),
          Chat(
            id: '',
            timestamp: msg.timestamp,
            lastMessage: msg,
          ).toMap());

      batch.update(
          FirebaseFirestore.instance
              .collection('user_chats')
              .doc(recieverId)
              .collection('data')
              .doc('${recieverId}_${AuthBloc.uid}'),
          {'id': AuthBloc.uid});

      batch.commit();
    } on FirebaseException catch (e) {
      print('Error:$e');
    }
  }

  Stream<List<Chat>> get chats {
    return FirebaseFirestore.instance
        .collection('user_chats')
        .doc(AuthBloc.uid)
        .collection('data')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((chat) => Chat.fromMap(chat.data())).toList());
  }

  Stream<List<Message>> messages(String uid) {
    var key = AuthBloc.uid.hashCode + uid.hashCode;
    return FirebaseFirestore.instance
        .collection('messages')
        .doc('msg_$key')
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((chat) => Message.fromMap(chat.data())).toList());
  }

  Future<void> deleteNotification(String notificationId, String uid) async {
    FirebaseFirestore.instance
        .collection("notifications")
        .doc(uid)
        .collection("notifs")
        .doc(notificationId)
        .delete();
  }
}
