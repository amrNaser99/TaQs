import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taQs/core/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  backgroundColor: Colors.white24,
  scaffoldBackgroundColor: colorPrimary,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
ThemeData darkTheme = ThemeData();
