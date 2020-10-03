import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
      print(url);
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

  Future<List<User>> get users async{
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection(
          "users").get();
      return querySnapshot.docs.map((e) => User.fromJson(e.data())).toList();
    }catch(e){
      print(e);
    }
  }
}
