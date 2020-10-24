part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class UsersLoadingState extends DataState {}

class UserDetailsLoadingState extends DataState {}

class PostsLoadingState extends DataState {}

class UserDataState extends DataState {
  final User user;
  UserDataState({this.user});

  @override
  List<Object> get props => [user];
}

class UsersFetchedState extends DataState {
  final List<User> users;
  UsersFetchedState({this.users});

  @override
  List<Object> get props => [users];
}

class PostSavingState extends DataState {}

class PostSavedState extends DataState {
  final String postId;

  PostSavedState(this.postId);

  @override
  List<Object> get props => [postId];
}

class PostsFetchedState extends DataState {
  final List<Post> posts;

  PostsFetchedState({this.posts});

  @override
  List<Object> get props => [posts];
}

class SendingRequestState extends DataState{
   @override
  List<Object> get props => [];
}

class RequestSentState extends DataState {
  final String requestId;
  RequestSentState({this.requestId});
  @override
  List<Object> get props => [requestId];
}

class RequestError extends DataState {
  final String error;
  RequestError({this.error});
  @override
  List<Object> get props => [error];
}

class RefreshState extends DataState{
  @override
  List<Object> get props => [];
}
