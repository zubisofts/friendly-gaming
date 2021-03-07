import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/auth_repository.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationRepository authenticationRepository;
  StreamSubscription<User> _authStateChangesSubcription;

  String name;
  String email;
  String password;
  File photo;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isNameValid = true;

  static String uid = '';

  AuthBloc({this.authenticationRepository}) : super(AuthInitial()) {
    _authStateChangesSubcription?.cancel();
    _authStateChangesSubcription = authenticationRepository.user.listen((user) {
      add(AuthStateChangedEvent(user: user));
      print('Something changed:${user?.name}');
    });
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is OnSubmitLoginFormDetailsEvent) {
      if (event.isEmail) {
        email = event.email;
      } else {
        password = event.password;
      }

      yield* _mapSubmitFormDetailsToState();
    }

    if (event is OnSubmitSignupDetailsEvent) {
      if (event.which == 1) {
        name = event.name;
      }

      if (event.which == 2) {
        email = event.email;
      }

      if (event.which == 3) {
        password = event.password;
      }

      if (event.which == 0) {
        photo = event.photo;
      }

      yield* _mapSubmitSignupFormDetailsToState();
    }

    if (event is LoginWithEmailAndPasswordEvent) {
      yield* _mapLoginEventToState();
    }

    if (event is SignupWithEmailAndPasswordEvent) {
      yield* _mapSignupWithEmailAndPasswordEventToState();
    }

    if (event is LoginWithGoogleEvent) {
      yield* _mapLoginWithGoogleEventToState();
    }

    if (event is SignupWithFacebokEvent) {
      yield* _mapSignupWithFacebookEventToState();
    }

    if (event is LoginWithFacebokEvent) {
      yield* _mapLoginWithFacebokEventToState();
    }

    if (event is SignupWithGoogleEvent) {
      yield* _mapSignupWithGoogleEventToState();
    }

    if (event is LogoutEvent) {
      authenticationRepository.logOut();
    }

    if (event is AuthStateChangedEvent) {
      // var user =event.user?.id !=null ? await new DataRepository().user(event.user.id):null;
      uid = event.user?.id;
      if(event.user != null){
        authenticationRepository.saveDeviceToken(event.user?.id);
      }
      
      yield AuthStateChangedState(user: event.user);
    }
  }

  Stream<AuthState> _mapLoginEventToState() async* {
    yield AuthLoadingState();
    try {
      await authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      yield AuthErrorState(errorMessage: e.message);
    }
  }

  Stream<AuthState> _mapSubmitFormDetailsToState() async* {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (email != null) {
      bool emailRes = emailRegExp.hasMatch(email);
      isEmailValid = emailRes;
    }

    if (password != null) {
      final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
      bool passwordRes = passwordRegExp.hasMatch(password);
      isPasswordValid = passwordRes;
    }

    yield OnLoginFormSubmittedState(
        emailRes: isEmailValid,
        email: email,
        passwordRes: isPasswordValid,
        password: password);
  }

  Stream<AuthState> _mapLoginWithGoogleEventToState() async* {
    try {
      await authenticationRepository.signInGoogle(true);
    } on LogInWithGoogleFailure catch (ex) {
      yield AuthErrorState(errorMessage: ex.message);
    }
  }

  Stream<AuthState> _mapSubmitSignupFormDetailsToState() async* {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (email != null) {
      bool emailRes = emailRegExp.hasMatch(email);
      isEmailValid = emailRes;
    }

    if (password != null) {
      final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
      bool passwordRes = passwordRegExp.hasMatch(password);
      isPasswordValid = passwordRes;
    }

    if (name != null) {
      bool nameRes = name.length > 0;
      isNameValid = nameRes;
    }

    yield OnSignupFormSubmittedState(
        name: name,
        nameRes: isNameValid,
        emailRes: isEmailValid,
        email: email,
        passwordRes: isPasswordValid,
        password: password,
        photo: photo);
  }

  Stream<AuthState> _mapSignupWithEmailAndPasswordEventToState() async* {
    try {
      yield AuthLoadingState();
      var user = await authenticationRepository.signUp(
          name: name, email: email, password: password, photo: photo);
      // print('Signedup User email:${user?.email}');
      // await authenticationRepository.logInWithEmailAndPassword(email: user?.email, password: password);
      yield AuthStateChangedState(user: user);
    } on SignUpFailure catch (e) {
      print(e.message);
    }
  }

  Stream<AuthState> _mapSignupWithGoogleEventToState() async* {
    try {
      yield AuthLoadingState();
      await authenticationRepository.signInGoogle(false);
    } on SignUpFailure catch (e) {
      yield AuthErrorState(errorMessage: e.message);
      print(e.message);
    }
  }

  Stream<AuthState> _mapSignupWithFacebookEventToState() async* {
    try {
      await authenticationRepository.SignupUserWithFBCredentials();
    } on LogInWithFacebookFailure catch (ex) {
      yield AuthErrorState(errorMessage: ex.message);
    }
  }

  Stream<AuthState> _mapLoginWithFacebokEventToState() async* {
    try {
      await authenticationRepository.loginUserWithFBCredentials();
    } on LogInWithFacebookFailure catch (ex) {
      yield AuthErrorState(errorMessage: ex.message);
    }
  }
}
