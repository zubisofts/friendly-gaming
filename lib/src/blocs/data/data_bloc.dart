import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/call.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
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

  List<FGNotification> notifications = [];

  DataBloc({this.dataRepository}) : super(DataInitial()) {
    _postsStateChangesSubscription = dataRepository.posts.listen((posts) {
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
      yield* _mapAddPostEventToState(event.post);
    }

    if (event is FetchPostEvent) {
      yield* _mapFetchPostsEventToState();
    }

    if (event is PostFetchedEvent) {
      yield PostsFetchedState(posts: event.posts);
    }

    if (event is SendRequestEvent) {
      yield* _mapSendRequestEventToState(Request(
        receiverId: event.receiverId,
        senderId: AuthBloc.uid,
        date: DateTime.now().millisecondsSinceEpoch,
        requestType: event.requestType,
        status: RequestStatus.Pending.toString().split('.').last,
      ));
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
        add(NotificationsFetchedEvent(notifications: notifications));
      });
    }

    if (event is IncomingCallEvent) {
      _callChangeSubscription = dataRepository.call.listen((call) {
        add(SendIncomingCallEvent(call: call));
      });
    }

    if (event is SendIncomingCallEvent) {
      yield IncomingCallRecievedState(call: event.call);
    }

    if (event is RequestResponseEvent) {
      await dataRepository.respondToGameRequest(event.accept, event.request);
    }

    if (event is RefreshEvent) {
      yield RefreshState();
    }
  }

  @override
  Future<void> close() {
    _postsStateChangesSubscription?.cancel();
    _notificationChangesSubscription?.cancel();
    _userDetailsChangesSubscription?.cancel();
    _callChangeSubscription?.cancel();
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

  Stream<DataState> _mapAddPostEventToState(Post post) async* {
    try {
      yield PostSavingState();
      String postId = await dataRepository.savePost(post);
      yield PostSavedState(postId);
    } catch (e) {}
  }

  Stream<DataState> _mapFetchPostsEventToState() async* {
    _postsStateChangesSubscription?.cancel();
    _postsStateChangesSubscription = dataRepository.posts.listen((posts) {
      add(PostFetchedEvent(posts: posts));
    });
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
}
