import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:friendly_gaming/src/model/post.dart';
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

  Future<List<User>> get users async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      return querySnapshot.docs
          .map((doc) => User.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<User>> searchUsers(String query) async {
    print(query);
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      // print(querySnapshot.docs.length);
      return querySnapshot.docs
          .map((e) => User.fromJson(e.data()))
          .where((element) =>
              element.name.toLowerCase().startsWith(query.toLowerCase()))
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

  Future<List<Post>> convertSnapshots(QuerySnapshot snapshots) async {
    return snapshots.docs.map((doc) {
      return Post.fromMap(doc.data());
    }).toList();
  }
}
