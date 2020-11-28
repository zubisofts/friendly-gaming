part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataErrorState extends DataState {}

class DataLoadingState extends DataState {}

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

class SendingRequestState extends DataState {
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

class RequestsFetchedState extends DataState {
  final List<Request> requests;
  RequestsFetchedState({this.requests});

  @override
  List<Object> get props => [requests];
}

class RefreshState extends DataState {
  @override
  List<Object> get props => [];
}

class NotificationsFetchedState extends DataState {
  final List<FGNotification> notifications;
  NotificationsFetchedState({@required this.notifications});
  @override
  List<Object> get props => [notifications];
}

class IncomingCallReceivedState extends DataState {
  final Call call;
  IncomingCallReceivedState({@required this.call});
  @override
  List<Object> get props => [call];
}

class ChatsFetchedState extends DataState {
  final List<Chat> chats;

  ChatsFetchedState({@required this.chats});

  @override
  List<Object> get props => [chats];
}

class MessageSendErrorState extends DataState {}

class MessageSentState extends DataState {
  final String messageId;
  MessageSentState({@required this.messageId});

  @override
  List<Object> get props => [messageId];
}

class MessagesFetchedState extends DataState {
  final List<Message> messages;
  MessagesFetchedState({@required this.messages});
  @override
  List<Object> get props => [messages];
}
