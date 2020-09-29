import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageException implements Exception{
  final String message;
  StorageException({this.message});
}

class DataRepository{

  StorageReference _storageReference=FirebaseStorage.instance.ref();

  Future<dynamic> saveProfileImage({String uid, File photo}) async{
    try {
      final StorageUploadTask uploadTask = _storageReference.child(
          'profile_images')
          .child('$uid.jpg').putFile(photo);
      StorageTaskSnapshot snapshot= await uploadTask.onComplete;
      String url=await snapshot.ref.getDownloadURL();
      print('************************************uploaded*************************');
      print(url);
      return url;
    } catch(e){
      print(e);
      // throw StorageException(message: e.toString());
    }
  }

}