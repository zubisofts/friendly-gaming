part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class ThemeChangedState extends AppState {
  final bool isLightTheme;

  ThemeChangedState({this.isLightTheme});

  @override
  List<Object> get props => [isLightTheme];
}

class GetThemeValueState extends AppState {
  final bool value;

  GetThemeValueState({this.value});

  @override
  List<Object> get props => [value];
}
