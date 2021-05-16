import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:friendly_gaming/src/model/user.dart' as UserModel;
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  final String message;

  SignUpFailure({this.message});
}

///ng the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {
  String message;

  LogInWithEmailAndPasswordFailure(this.message);
}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  String message;

  LogInWithGoogleFailure({this.message});
}

class LogInWithFacebookFailure implements Exception {
  String message;

  LogInWithFacebookFailure({this.message});
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
    FirebaseMessaging firebaseMessaging,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _facebookLogin = FacebookLogin(),
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: [
                'email',
                // 'https://www.googleapis.com/auth/contacts.readonly',
              ],
            ),
        _firebaseMessaging = FirebaseMessaging();

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final FirebaseMessaging _firebaseMessaging;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<UserModel.User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? null : firebaseUser.toUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<UserModel.User> signUp({
    @required File photo,
    @required String name,
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = userCredential.user.toUser;
      String url = '';
      Map<String, dynamic> userData = user.toJson();
      userData['name'] = name;
      if (photo != null) {
        var exists = await photo.exists();
        if (exists) {
          url = await saveImageToStorage(user.id, photo);
          userData['photo'] = url;
          return await addUserToB(userData);
        }
      } else {
        userData['photo'] =
            'https://www.iconfinder.com/data/icons/avatars-circle-2/72/146-512.png';
        return await addUserToB(userData);
      }
    } on FirebaseException catch (e) {
      throw SignUpFailure(message: e.message);
    }
  }

  Future<void> signInGoogle(bool login) async {
    if (login) {
      await logInWithGoogle();
    } else {
      final googleUser = await _googleSignIn.signIn();
      await signupWithGoogle(googleUser);
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      List<String> list =
          await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
      if (list.isNotEmpty && list.elementAt(0) == 'google.com') {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
      } else {
        // await _googleSignIn.signOut();
        // throw LogInWithGoogleFailure(message: "Sorry user does not exist");
        await signupWithGoogle(googleUser);
      }
    } on FirebaseException catch (e) {
      print('ex:${e.message}');
      throw LogInWithGoogleFailure(message: e.message);
    } on Exception catch (ex) {
      print('ex:${ex}');
      throw LogInWithGoogleFailure(message: '$ex');
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<UserModel.User> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user.toUser;
    } on FirebaseAuthException catch (ex) {
      throw LogInWithEmailAndPasswordFailure(ex.message);
    }
  }

  Future<UserModel.User> signupWithGoogle(
      GoogleSignInAccount googleUser) async {
    try {
      // final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      List<String> list =
          await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
      if (list.isEmpty) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        return addUserToB(userCredential.user.toUser.toJson());
      } else {
        await _googleSignIn.signOut();
        throw SignUpFailure(message: "Sorry user already exists.");
      }
    } on FirebaseException catch (e) {
      print('ex:${e.message}');
      throw SignUpFailure(message: e.message);
    }
  }

  Future<void> SignupUserWithFBCredentials() async {
    try {
      final result = await _facebookLogin.logIn(["email"]);
      // print('Result:${result.errorMessage}');
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          var credential =
              FacebookAuthProvider.credential(result.accessToken.token);
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
          final profile = json.decode(graphResponse.body);

          List<String> list =
              await _firebaseAuth.fetchSignInMethodsForEmail(profile['email']);
          if (list.isNotEmpty) {
            throw LogInWithFacebookFailure(
                message: "User with this account already exist.");
          } else {
            var userCredential =
                await _firebaseAuth.signInWithCredential(credential);
            await addUserToB(userCredential.user.toUser.toJson());
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          throw LogInWithFacebookFailure(message: result.errorMessage);
//        _showCancelledMessage();
          break;
        case FacebookLoginStatus.error:
          print('Result:${result.errorMessage}');
//        _showErrorOnUI(result.errorMessage);
          break;
      }
    } on FirebaseException catch (error) {
      print(error);
      throw LogInWithFacebookFailure(message: error.message);
    }
  }

  Future<void> loginUserWithFBCredentials() async {
    try {
      final result = await _facebookLogin.logIn(["email"]);
      // print('Result:${result.errorMessage}');
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          var credential =
              FacebookAuthProvider.credential(result.accessToken.token);
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
          final profile = json.decode(graphResponse.body);

          List<String> list =
              await _firebaseAuth.fetchSignInMethodsForEmail(profile['email']);
          if (list.isEmpty) {
            throw LogInWithFacebookFailure(
                message: "User with this account does not exist.");
          } else {
            await _firebaseAuth.signInWithCredential(credential);
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Error:Facebook Canceled');
//        _showCancelledMessage();
          break;
        case FacebookLoginStatus.error:
          print('Result:${result.errorMessage}');
//        _showErrorOnUI(result.errorMessage);
          break;
      }
    } on FirebaseException catch (error) {
      print(error);
      throw LogInWithFacebookFailure(message: error.message);
    }
  }

  Future<UserModel.User> addUserToB(Map<String, dynamic> userData) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userData['id'])
          .set(userData);

      await saveDeviceToken(userData['id']);
      return UserModel.User.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      throw SignUpFailure(message: e.message);
    }
  }

  Future<String> saveImageToStorage(String id, File photo) async {
    try {
      return await new DataRepository().saveProfileImage(uid: id, photo: photo);
    } on StorageException catch (e) {
      print('Storage error:${e.message}');
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth?.signOut(),
        _googleSignIn?.signOut(),
        _facebookLogin.logOut()
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  /// Get the token, save it to the database for current user
  Future<void> saveDeviceToken(String uid) async {
    // Get the token for this device
    String fcmToken = await _firebaseMessaging.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      await _firebaseFirestore
          .collection('user_tokens')
          .doc(uid)
          .collection('tokens')
          .doc(Platform.operatingSystem)
          .set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
}

extension on User {
  UserModel.User get toUser {
    return UserModel.User(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}
