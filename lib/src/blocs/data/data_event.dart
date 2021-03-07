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
  final Request request;

  AddPostEvent(this.post, {this.request});

  @override
  List<Object> get props => [post, request];
}

class EditPostEvent extends DataEvent {
  final Map<String, dynamic> data;
  final String postId;

  EditPostEvent(this.data, this.postId);

  @override
  List<Object> get props => [data];
}

class FetchPostEvent extends DataEvent {
  final int page;

  FetchPostEvent({this.page});
  @override
  List<Object> get props => [];
}

class PostFetchedEvent extends DataEvent {
  final List<Post> posts;

  PostFetchedEvent({this.posts});

  @override
  List<Object> get props => [posts];
}

class AddCommentEvent extends DataEvent {
  final Comment comment;

  AddCommentEvent(
    this.comment,
  );

  @override
  List<Object> get props => [comment];
}

class DeleteCommentEvent extends DataEvent {
  final String commentId;
  final String postId;

  DeleteCommentEvent({this.commentId, this.postId});

  @override
  List<Object> get props => [commentId, postId];
}

class AddLikeEvent extends DataEvent {
  final Like like;

  AddLikeEvent(
    this.like,
  );

  @override
  List<Object> get props => [like];
}

class RemoveLikeEvent extends DataEvent {
  final String likeId;
  final String postId;

  RemoveLikeEvent({this.likeId, this.postId});

  @override
  List<Object> get props => [likeId, postId];
}

class SendRequestEvent extends DataEvent {
  final Request request;

  SendRequestEvent({this.request});

  @override
  List<Object> get props => [request];
}

class FetchRequestsEvent extends DataEvent {
  @override
  List<Object> get props => [];
}

class RequestsFetchedEvent extends DataEvent {
  final List<Request> requests;

  RequestsFetchedEvent({this.requests});

  @override
  List<Object> get props => [requests];
}

class RequestResponseEvent extends DataEvent {
  final bool accept;
  final Request request;

  RequestResponseEvent({this.accept, this.request});

  @override
  List<Object> get props => [accept, request];
}

class RefreshEvent extends DataEvent {}

class FetchNotificationEvent extends DataEvent {}

class NotificationsFetchedEvent extends DataEvent {
  final List<FGNotification> notifications;

  NotificationsFetchedEvent({this.notifications});

  @override
  List<Object> get props => [notifications];
}

class IncomingCallEvent extends DataEvent {
  @override
  List<Object> get props => [];
}

class SendIncomingCallEvent extends DataEvent {
  final Call call;

  SendIncomingCallEvent({this.call});

  @override
  List<Object> get props => [call];
}

class EndCallEvent extends DataEvent {
  final Call call;

  EndCallEvent({this.call});

  @override
  List<Object> get props => [call];
}

class FetchChatsEvent extends DataEvent {
  @override
  List<Object> get props => [];
}

class ChatsFetchedEvent extends DataEvent {
  final List<Chat> chats;

  ChatsFetchedEvent({@required this.chats});

  @override
  List<Object> get props => [chats];
}

class SendMessageEvent extends DataEvent {
  final Message message;
  final String receiverId;
  SendMessageEvent({@required this.message, @required this.receiverId});

  @override
  List<Object> get props => [message, receiverId];
}

class FetchMessagesEvent extends DataEvent {
  // Other user ID
  final String receiverId;
  FetchMessagesEvent({@required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class MessagesFetchedEvent extends DataEvent {
  final List<Message> messages;
  MessagesFetchedEvent({@required this.messages});
  @override
  List<Object> get props => [props];
}

class FetchCommentsEvent extends DataEvent {
  final String postId;
  FetchCommentsEvent(this.postId);
  @override
  List<Object> get props => [postId];
}

class CommentsFetchedEvent extends DataEvent {
  final List<Comment> comments;
  CommentsFetchedEvent(this.comments);
  @override
  List<Object> get props => [comments];
}

class FetchLikesEvent extends DataEvent {
  final String postId;
  FetchLikesEvent(this.postId);
  @override
  List<Object> get props => [postId];
}

class LikesFetchedEvent extends DataEvent {
  final List<Like> likes;
  LikesFetchedEvent(this.likes);
  @override
  List<Object> get props => [likes];
}
