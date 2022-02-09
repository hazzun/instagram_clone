import 'package:flutter/material.dart';

var theme = ThemeData(
  iconTheme: IconThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black)
  ),
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.redAccent)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 1,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
  )
);