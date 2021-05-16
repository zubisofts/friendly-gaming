import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/app/app_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/repository/auth_repository.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/utils/app_theme.dart';
import 'src/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print('Data: $data');
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print('Data: $notification');
  }

  // Or do other work.
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  StreamSubscription iosSubscription;

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  final DataRepository dataRepository = DataRepository();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage:
          Platform.isAndroid ? myBackgroundMessageHandler : null,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    if (Platform.isIOS) {
      iosSubscription =
          _firebaseMessaging.onIosSettingsRegistered.listen((data) {});

      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    super.initState();
  }

  @override
  void dispose() {
    iosSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                  authenticationRepository: authenticationRepository,
                )),
        BlocProvider<DataBloc>(
            create: (context) => DataBloc(dataRepository: dataRepository)),
        BlocProvider<AppBloc>(create: (context) => AppBloc())
      ],
      child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        bool value = false;
        if (state is GetThemeValueState) {
          value = state.value;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Friendly Gaming',
          theme: AppTheme.lightTheme
              .copyWith(visualDensity: VisualDensity.adaptivePlatformDensity),
          darkTheme: AppTheme.darkTheme.copyWith(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.dark),
          themeMode: !value ? ThemeMode.light : ThemeMode.dark,
          home: SplashScreen(),
        );
      }),
    );
  }
}
