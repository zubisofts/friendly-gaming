import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/repository/auth_repository.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/screens/homescreen.dart';
import 'package:friendly_gaming/src/screens/auth_screen.dart';
import 'package:friendly_gaming/src/screens/profile_screen.dart';
import 'package:friendly_gaming/src/screens/signup_screen.dart';
import 'package:friendly_gaming/src/screens/statistics_screen.dart';
import 'src/screens/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();

  // final FirebaseStorage storage = FirebaseStorage(
  //     app: app, storageBucket: 'gs://flutter-firebase-plugins.appspot.com');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final DataRepository dataRepository=DataRepository();
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Friendly Gaming',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: SplashScreen(),
        home: SplashScreen(),
      ),
    );
  }
}
