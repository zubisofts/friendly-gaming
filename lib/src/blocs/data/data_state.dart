part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();
  
  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class UsersLoadingState extends DataState{}

class UserDetailsLoadingState extends DataState{}

class UserDataState extends DataState {
  final User user;
  UserDataState({this.user});

  @override
  List<Object> get props => [user];
}

class UsersFetchedState extends DataState{
  final List<User> users;
  UsersFetchedState({this.users});

  @override
  List<Object> get props => [users];
}
