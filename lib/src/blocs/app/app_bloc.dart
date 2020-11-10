import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendly_gaming/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    add(GetThemeValueEvent());
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is ChangeThemeEvent) {
      yield* _mapChangeThemeEventToState();
    }

    if (event is GetThemeValueEvent) {
      final pref = await SharedPreferences.getInstance();
      var themeValue = pref.getBool(Constants.THEME_PREF_KEY) ?? false;
      yield GetThemeValueState(value: themeValue ?? false);
    }
  }

  Stream<AppState> _mapChangeThemeEventToState() async* {
    try {
      final pref = await SharedPreferences.getInstance();
      bool themeValue = pref.getBool(Constants.THEME_PREF_KEY) ?? false;
      await pref.setBool(Constants.THEME_PREF_KEY, !themeValue);
      bool value = pref.getBool(Constants.THEME_PREF_KEY);
      yield GetThemeValueState(value: value);
      print('Working here in AppBloc $value');
    } catch (e) {
      print(e);
    }
  }
}
