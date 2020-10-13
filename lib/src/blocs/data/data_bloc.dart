import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataRepository dataRepository;
  DataBloc({this.dataRepository}) : super(DataInitial());

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

    if (event is SearchUserEvent) {
      yield* _mapSearchUserEventToState(event.query);
    }
  }

  Stream<DataState> _mapUserDataEventToState(String uid) async* {
    try {
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
      List<User> users = await dataRepository.users;
      yield UsersFetchedState(users: users);
    } catch (e) {}
  }

   Stream<DataState> _mapSearchUserEventToState(String query) async* {
    try {
      yield UsersLoadingState();
      List<User> users = await dataRepository.searchUsers(query);
      yield UsersFetchedState(users: users);
    } catch (e) {}
  }
}
