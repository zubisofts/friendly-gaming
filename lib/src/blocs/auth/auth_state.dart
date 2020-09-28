part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStateChangedState extends AuthState {
  final User user;

  AuthStateChangedState({this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class OnLoginFormSubmittedState extends AuthState {
  final bool emailRes;
  final bool passwordRes;
  final String email;
  final String password;
  final String photo;

  OnLoginFormSubmittedState(
      {this.photo, this.email, this.password, this.emailRes, this.passwordRes});

  @override
  List<Object> get props => [email, password, emailRes, passwordRes];
}

class OnSignupFormSubmittedState extends AuthState {
  final String name;
  final bool nameRes;
  final bool emailRes;
  final bool passwordRes;
  final String email;
  final String password;
  final File photo;

  OnSignupFormSubmittedState(
      {this.name,
      this.nameRes,
      this.photo,
      this.email,
      this.password,
      this.emailRes,
      this.passwordRes});

  @override
  List<Object> get props =>
      [name, nameRes, email, password, emailRes, passwordRes,photo];
}
