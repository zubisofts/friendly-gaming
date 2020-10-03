part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class UserDataEvent extends DataEvent{
  final String uid;
  UserDataEvent({this.uid});

  @override
  List<Object> get props => [uid];
}

class FetchUsersEvent extends DataEvent{}