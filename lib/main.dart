import 'package:flutter/material.dart';
import 'heroes.dart';
import 'settings.dart';
import 'comics.dart';
import 'login.dart';


void main() => runApp(MaterialApp(
      home: Login(),
      theme: new ThemeData(
        primaryColor: Colors.red[600], //Changing this will change the color of the TabBar
        fontFamily: 'Marvel',
        appBarTheme: AppBarTheme(color: Colors.red[600]),
        accentColor: Colors.red[400],
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
            icon: new Icon(Icons.library_books),
            text: "Quadrinhos",
          ),
          Tab(
            icon: new Icon(Icons.people),
            text: "Heróis",
          ),
          Tab(
            icon: new Icon(Icons.settings),
            text: "Configurações",
          )
        ],
        labelColor: Colors.red,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
/*         indicatorColor: Colors.black,
 */      ),
    ),
  );
}
