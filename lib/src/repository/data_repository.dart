import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/call.dart';
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

  Future<String> savePost(Post post) async {
    Map<String, dynamic> update = {};
    try {
      var documentReference = await FirebaseFirestore.instance
          .collection("posts")
          .add(post.toMap());
      update['id'] = documentReference.id;
      documentReference.update(update);

      String s1 = post.images[0] != null
          ? await DataRepository().savePostImage(
              documentReference.id, 'image_1', File(post.images[0]))
          : '';
      String s2 = post.images[1] != null
          ? await DataRepository().savePostImage(
              documentReference.id, 'image_2', File(post.images[1]))
          : '';
      String s3 = post.images[2] != null
          ? await DataRepository().savePostImage(
              documentReference.id, 'image_3', File(post.images[2]))
          : '';

      List<String> images = [s1, s2, s3];
      update['images'] = images;

      documentReference.update(update);

      return documentReference.id;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Stream<List<Post>> get posts {
    try {
      return FirebaseFirestore.instance
          .collection("posts")
          .orderBy('date', descending: true)
          .snapshots()
          .asyncMap((snapshots) async {
        return await convertSnapshots(snapshots);
      });
      //
    } on FirebaseException catch (ex) {
      print(ex.message);
    }
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
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(AuthBloc.uid)
          .collection('game_requests')
          .doc(request.requestId)
          .delete();
    } on FirebaseException catch (e) {
      print(e);
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
}
