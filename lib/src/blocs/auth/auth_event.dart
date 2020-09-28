part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {}

class SignupWithEmailAndPasswordEvent extends AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final User user;
  AuthStateChangedEvent({this.user});

  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthEvent {}

class SignupEvent extends AuthEvent {}

class LoginWithGoogleEvent extends AuthEvent {}

class SignupWithGoogleEvent extends AuthEvent {}

class LoginWithFacebokEvent extends AuthEvent {}

class SignupWithFacebokEvent extends AuthEvent {}

class OnSubmitLoginFormEvent extends AuthEvent {}

class OnSubmitLoginFormDetailsEvent extends AuthEvent {
  final String name;
  final bool isEmail;
  final String email;
  final String password;
  final String photo;

  OnSubmitLoginFormDetailsEvent(
      {this.name, this.email, this.password, this.isEmail,this.photo});

  @override
  List<Object> get props => [name, email, password, isEmail,photo];
}

class OnSubmitSignupDetailsEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final File photo;
  final int which;

  OnSubmitSignupDetailsEvent(
      {this.name, this.email, this.password,this.photo,this.which});

  @override
   List<Object> get props => [name, email, password,photo,which];
}
