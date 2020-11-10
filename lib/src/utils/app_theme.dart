import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: "Poppins-Light",
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(caption: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(
        color: Colors.blueGrey,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.blue,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.blueGrey,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        // fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.blueGrey,
        // fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF141d26),
    cardColor: Color(0xFF243447),
    fontFamily: "Poppins-Light",
    appBarTheme: AppBarTheme(
      color: Color(0xFF243447),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF141d26),
      onPrimary: Color(0xFF141d26),
      primaryVariant: Color(0xFF141d26),
      secondary: Colors.blue,
    ),
    cardTheme: CardTheme(
      color: Color(0xFF243447).withOpacity(0.5),
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.white),
      headline6: TextStyle(
        color: Colors.white,
        // fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        // fontSize: 18.0,
      ),
    ),
  );
}
