import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      color: HexColor("FAFAFA"),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
      )),
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      elevation: 20.0),
  backgroundColor: HexColor('FAFAFA'),
);
