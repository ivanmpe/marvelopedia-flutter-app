import 'package:flutter/material.dart';
import 'heroes.dart';
import 'comics.dart';
import 'login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: _scaffold(),
    );
  }
}

Widget _scaffold() {
  return Scaffold(
    body: TabBarView(
      children: [
        new Container(
          child: Comics(),
        ),
        new Container(
          child: Heroes(),
        ),
      ],
    ),
    bottomNavigationBar: Container(
      child: new TabBar(
        tabs: [
          Tab(
            icon: new FaIcon(FontAwesomeIcons.bookOpen),
          ),
          Tab(
            icon: new FaIcon(FontAwesomeIcons.mask),
          )
        ],
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.black,
      ),
    ),
  );
}
