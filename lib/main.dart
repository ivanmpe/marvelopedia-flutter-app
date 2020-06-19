import 'package:flutter/material.dart';
import 'package:marvelopedia_flutter_app/screens/login.dart';

const PrimaryColorDark = const Color(0x4DFFFFFF);

void main() => runApp(MaterialApp(
      home: Login(),
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[600],
        fontFamily: 'Marvel',
        appBarTheme: AppBarTheme(color: Colors.red[600]),
        accentColor: Colors.white,
        backgroundColor: Colors.black,
        tabBarTheme: TabBarTheme(
            labelColor: Colors.red[600], unselectedLabelColor: Colors.grey[500]),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Marvel',
        accentColor: Colors.white,
        backgroundColor: Colors.grey[500],
        appBarTheme: AppBarTheme(color: PrimaryColorDark),
        tabBarTheme: TabBarTheme(
            labelColor: Colors.white, unselectedLabelColor: Colors.grey[500]),
      ),
    ));

