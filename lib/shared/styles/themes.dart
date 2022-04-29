import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: HexColor('333738'),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333738'),
      statusBarIconBrightness: Brightness.light,
    ),
    color: HexColor('333738'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333738'),
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedIconTheme: const IconThemeData(
      color: defualtColor,
      size: 40.0,
    ),
    selectedLabelStyle: const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    unselectedItemColor: Colors.grey,
    selectedItemColor: defualtColor,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: 'Janna',
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20.0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedIconTheme: IconThemeData(
      color: defualtColor,
      size: 40.0,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black,
    selectedItemColor: defualtColor,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: 'Janna',
);
