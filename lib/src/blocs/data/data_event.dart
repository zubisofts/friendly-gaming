part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class UserDataEvent extends DataEvent {
  final String uid;

  UserDataEvent({this.uid});

  @override
  List<Object> get props => [uid];
}

class FetchUsersEvent extends DataEvent {
  @override
  List<Object> get props => [];
}

class FetchUserDetailsEvent extends DataEvent {
  final String uid;

  FetchUserDetailsEvent({@required this.uid});

  @override
  List<Object> get props => [uid];
}

class UserFetchedEvent extends DataEvent {
  final User user;

  UserFetchedEvent({@required this.user});

  @override
  List<Object> get props => [user];
}

class SearchUserEvent extends DataEvent {
  final String query;

  SearchUserEvent({this.query});

  @override
  List<Object> get props => [query];
}

class AddPostEvent extends DataEvent {
  final Post post;

  AddPostEvent(this.post);

  @override
  List<Object> get props => [post];
}

class FetchPostEvent extends DataEvent {
  @override
  List<Object> get props => [];
}

class PostFetchedEvent extends DataEvent {
  final List<Post> posts;

  PostFetchedEvent({this.posts});

  @override
  List<Object> get props => [posts];
}

class SendRequestEvent extends DataEvent {
  final String requestType;
  final String receiverId;

  SendRequestEvent({this.requestType, this.receiverId});

  @override
  List<Object> get props => [requestType, receiverId];
}

class RefreshEvent extends DataEvent {}
