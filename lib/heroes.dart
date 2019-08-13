import 'package:flutter/material.dart';


class Heroes extends StatefulWidget {
  @override
  _HeroisState createState() => _HeroisState();
}

class _HeroisState extends State<Heroes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        automaticallyImplyLeading: false,
        title: Text("Heróis"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
