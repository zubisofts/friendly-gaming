import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/call.dart';
import 'package:friendly_gaming/src/model/chat.dart';
import 'package:friendly_gaming/src/model/comment.dart';
import 'package:friendly_gaming/src/model/like.dart';
import 'package:friendly_gaming/src/model/message.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/repository/messaging_repo.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataRepository dataRepository;
  StreamSubscription<List<Post>> _postsStateChangesSubscription;
  StreamSubscription<User> _userDetailsChangesSubscription;
  StreamSubscription<List<FGNotification>> _notificationChangesSubscription;
  StreamSubscription<List<Request>> _requestsChangesSubscription;
  StreamSubscription<Call> _callChangeSubscription;
  StreamSubscription<List<Message>> _messagesChangeSubscription;
  StreamSubscription<List<Comment>> _commentsChangeSubscription;
  StreamSubscription<List<Like>> _likesChangeSubscription;
  StreamSubscription<List<Chat>> _chatsChangeSubscription;

  DataBloc({this.dataRepository}) : super(DataInitial()) {
    _postsStateChangesSubscription =
        dataRepository.posts.call(page: 1).listen((posts) {
      add(PostFetchedEvent(posts: posts));
    });
    add(FetchRequestsEvent());
    add(IncomingCallEvent());
  }

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is UserDataEvent) {
      yield* _mapUserDataEventToState(event.uid);
    }

    if (event is FetchUsersEvent) {
      yield* _mapFetchUsersEventToState();
    }

    if (event is FetchUserDetailsEvent) {
      _userDetailsChangesSubscription =
          dataRepository.userDetails(event.uid).listen((user) {
        add(UserFetchedEvent(user: user));
      });
    }

    if (event is UserFetchedEvent) {
      yield UserDataState(user: event.user);
    }

    if (event is SearchUserEvent) {
      yield* _mapSearchUserEventToState(event.query);
    }

    if (event is AddPostEvent) {
      yield* _mapAddPostEventToState(event.post, event.request);
    }

    if (event is FetchPostEvent) {
      yield* _mapFetchPostsEventToState(page: event?.page);
    }

    if (event is PostFetchedEvent) {
      yield PostsFetchedState(posts: event.posts);
    }

    if (event is EditPostEvent) {
      yield* _mapEditPostEventToState(event.data, event.postId);
    }

    if (event is SendRequestEvent) {
      yield* _mapSendRequestEventToState(event.request);
    }

    if (event is FetchRequestsEvent) {
      _requestsChangesSubscription = dataRepository.requests.listen((requests) {
        add(RequestsFetchedEvent(requests: requests));
      });
    }

    if (event is RequestsFetchedEvent) {
      yield RequestsFetchedState(requests: event.requests);
    }

    if (event is NotificationsFetchedEvent) {
      yield NotificationsFetchedState(notifications: event.notifications);
    }

    if (event is FetchNotificationEvent) {
      _notificationChangesSubscription =
          dataRepository.notifications.listen((notifs) {
        // notifications.addAll(notifs);
        add(NotificationsFetchedEvent(notifications: notifs));
      });
    }

    if (event is IncomingCallEvent) {
      _callChangeSubscription = dataRepository.call.listen((call) {
        add(SendIncomingCallEvent(call: call));
      });
    }

    if (event is SendIncomingCallEvent) {
      yield IncomingCallReceivedState(call: event.call);
    }

    if (event is RequestResponseEvent) {
      await dataRepository.respondToGameRequest(event.accept, event.request);
    }

    if (event is EndCallEvent) {
      await dataRepository.endCall(event.call);
    }

    if (event is RefreshEvent) {
      yield RefreshState();
    }

    if (event is FetchChatsEvent) {
      _chatsChangeSubscription = dataRepository.chats.listen((chats) {
        add(ChatsFetchedEvent(chats: chats));
      });
    }

    if (event is ChatsFetchedEvent) {
      yield ChatsFetchedState(chats: event.chats);
    }

    if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event.message, event.receiverId);
    }

    if (event is FetchMessagesEvent) {
      _messagesChangeSubscription =
          dataRepository.messages(event.receiverId).listen((messages) {
        add(MessagesFetchedEvent(messages: messages));
      });
    }

    if (event is MessagesFetchedEvent) {
      yield MessagesFetchedState(messages: event.messages);
    }

    if (event is FetchCommentsEvent) {
      _commentsChangeSubscription =
          MessagingRepository().comments(event.postId).listen((comments) {
        add(CommentsFetchedEvent(comments));
      });
    }

    if (event is CommentsFetchedEvent) {
      yield CommentsLoadedState(comments: event.comments);
    }

    if (event is AddCommentEvent) {
      yield* _mapAddCommentEventToState(event.comment);
    }

    if (event is FetchLikesEvent) {
      _likesChangeSubscription =
          MessagingRepository().likes(event.postId).listen((likes) {
        add(LikesFetchedEvent(likes));
      });
    }

    if (event is LikesFetchedEvent) {
      yield LikesLoadedState(likes: event.likes);
    }

    if (event is AddLikeEvent) {
      MessagingRepository().addLike(event.like);
    }

    if (event is RemoveLikeEvent) {
      MessagingRepository().unLike(event.likeId, event.postId);
    }

    if (event is DeleteCommentEvent) {
      MessagingRepository().deleteComent(event.commentId, event.postId);
    }

    if (event is FetchUserGamesEvent) {
      yield* _mapFetchUserGamesEventToState(event.uid);
    }
  }

  @override
  Future<void> close() {
    _postsStateChangesSubscription?.cancel();
    _notificationChangesSubscription?.cancel();
    _userDetailsChangesSubscription?.cancel();
    _callChangeSubscription?.cancel();
    _requestsChangesSubscription?.cancel();
    _messagesChangeSubscription?.cancel();
    _chatsChangeSubscription?.cancel();
    _commentsChangeSubscription?.cancel();
    _likesChangeSubscription?.cancel();
    return super.close();
  }

  Stream<DataState> _mapUserDataEventToState(String uid) async* {
    try {
      yield UserDetailsLoadingState();
      var user = await dataRepository.user(uid);
      yield UserDataState(user: user);
    } on FirebaseException catch (e) {
      print(
          '****************************Fetch User Data Error*************************');
    }
  }

  Stream<DataState> _mapFetchUsersEventToState() async* {
    try {
      yield UsersLoadingState();
      List<User> users = await dataRepository.users(uid: AuthBloc.uid);
      yield UsersFetchedState(users: users);
    } catch (e) {}
  }

  Stream<DataState> _mapSearchUserEventToState(String query) async* {
    try {
      yield UsersLoadingState();
      List<User> users =
          await dataRepository.searchUsers(query, uid: AuthBloc.uid);
      yield UsersFetchedState(users: users);
    } catch (e) {}
  }

  Stream<DataState> _mapAddPostEventToState(Post post, Request request) async* {
    try {
      yield PostSavingState();
      String postId = await dataRepository.savePost(post, request);
      yield PostSavedState(postId);
    } catch (e) {
      print('Error saving POST:$e');
    }
  }

  Stream<DataState> _mapFetchPostsEventToState({int page}) async* {
    _postsStateChangesSubscription?.cancel();
    _postsStateChangesSubscription =
        dataRepository.posts.call(page: page).listen((posts) {
      add(PostFetchedEvent(posts: posts));
    });
  }

  Stream<DataState> _mapFetchUserGamesEventToState(uid) async* {
    try {
      yield FetchUserGamesLoading();
      List<Post> games = await dataRepository.getGames(uid);
      yield UserGamesFetched(games: games);
    } catch (e) {
      yield FetchUserGamesError(error: e.message);
    }
  }

  Stream<DataState> _mapSendRequestEventToState(Request request) async* {
    try {
      yield SendingRequestState();
      var requestId = await dataRepository.sendRequest(request);
      yield RequestSentState(requestId: requestId);
    } on FirebaseException catch (e) {
      yield RequestError(error: e.message);
    }
  }

  Stream<DataState> _mapSendMessageEventToState(
      Message message, String receiverId) async* {
    try {
      String id = await dataRepository.sendMessage(message, receiverId);
      if (id != null) {
        yield MessageSentState(messageId: id);
      } else {
        yield MessageSendErrorState();
      }
    } catch (e) {
      yield MessageSendErrorState();
    }
  }

  Stream<DataState> _mapEditPostEventToState(
      Map<String, dynamic> data, String postId) async* {
    try {
      yield PostEditingState();
      bool edited = await dataRepository.editPost(data, postId);
      if (edited) {
        yield PostEditedState();
      } else {
        yield PostEditErrorState();
      }
    } catch (e) {
      yield PostEditErrorState();
    }
  }

  Stream<DataState> _mapAddCommentEventToState(Comment comment) async* {
    try {
      // yield PostEditingState();
      String id = await MessagingRepository().addComent(comment);
      if (id != null) {
        yield CommentAddedState(commentId: id);
      }
    } catch (e) {
      // yield AddCommentError();
    }
  }
}
