import 'package:flutter/material.dart';

class SuperHero extends StatefulWidget {
  final int id;
  final String title;
  SuperHero({Key key, @required this.id, @required this.title}) : super(key: key);
  @override
  _SuperHeroState createState() => _SuperHeroState(this.id, this.title);
}

class _SuperHeroState extends State<SuperHero> {
  final int id;
  final String title;
  _SuperHeroState(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        automaticallyImplyLeading: false,
        title: Text("SuperHero"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          FlatButton(
            onPressed: () {},
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(),
    );
  }
}
