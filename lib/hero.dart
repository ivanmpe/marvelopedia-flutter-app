import 'package:flutter/material.dart';

class Hero extends StatefulWidget {
  final int id;
  Hero(this.id);
  @override
  _HeroState createState() => _HeroState();
}

class _HeroState extends State<Hero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        automaticallyImplyLeading: false,
        title: Text("Hero"),
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
