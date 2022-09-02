import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600
    ),
  ),
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  appBarTheme:   AppBarTheme(
      titleSpacing: 20,
      elevation: 0.0,
      backgroundColor: HexColor('333739'),
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      )

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor:  defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 50
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600
    ),
  ),
  appBarTheme:   const AppBarTheme(
      elevation: 0.0,
      titleSpacing: 20,
      backgroundColor: Colors.white,
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,


      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      )

  ),
  fontFamily: 'Jannah',
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor:  defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 50
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
);