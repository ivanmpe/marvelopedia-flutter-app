import 'package:flutter/material.dart';
import 'heroes.dart';
import 'settings.dart';
import 'comics.dart';
import 'login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
      home: Login(),
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[600],
        fontFamily: 'Marvel',
        appBarTheme: AppBarTheme(color: Colors.white),
        accentColor: Colors.red[400],
        backgroundColor: Colors.black
      ),
      darkTheme: new ThemeData(
        primaryColor: Colors.red[600],
        fontFamily: 'Marvel',
        appBarTheme: AppBarTheme(color: Colors.white),
        accentColor: Colors.red[400],
        backgroundColor: Colors.grey[500],
        brightness: Brightness.dark,
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
      length: 3,
      child: _scaffold(),
    );
  }
}

Widget _scaffold() {
  return Scaffold(
    backgroundColor: Colors.grey[100],
    body: TabBarView(
      children: [
        new Container(
          child: Comics(),
        ),
        new Container(
          child: Heroes(),
        ),
        new Container(
          child: Settings(),
        ),
      ],
    ),
    bottomNavigationBar: Container(
      color: Colors.white,
      child: new TabBar(
        tabs: [
          Tab(
            icon: new FaIcon(FontAwesomeIcons.bookOpen),
            text: "Quadrinhos",
          ),
          Tab(
            icon: new FaIcon(FontAwesomeIcons.mask),
            text: "Heróis",
          ),
          Tab(
            icon: new FaIcon(FontAwesomeIcons.cog),
            text: "Configurações",
          )
        ],
        labelColor: Colors.red,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
/*         indicatorColor: Colors.black,
 */
      ),
    ),
  );
}
