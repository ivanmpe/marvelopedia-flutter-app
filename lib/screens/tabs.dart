import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marvelopedia_flutter_app/screens/comics.dart';

import 'heroes.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
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
            icon: new Icon(FontAwesomeIcons.bookOpen),
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
