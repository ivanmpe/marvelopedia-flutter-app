import 'package:flutter/material.dart';

class Comic extends StatefulWidget {
  final int id;
  Comic({Key key, @required this.id}) : super(key: key);
  @override
  _ComicState createState() => _ComicState();
}

class _ComicState extends State<Comic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        automaticallyImplyLeading: false,
        title: Text("comic"),
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
