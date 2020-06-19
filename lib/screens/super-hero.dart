import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvelopedia_flutter_app/api/super-hero-api.dart';
import 'package:marvelopedia_flutter_app/screens/sign_in.dart';

class SuperHero extends StatefulWidget {
  final int id;
  final String name;
  SuperHero({Key key, @required this.id, @required this.name})
      : super(key: key);
  @override
  _SuperHeroState createState() => _SuperHeroState(this.id, this.name);
}

class _SuperHeroState extends State<SuperHero> {
  final int id;
  final String name;
  _SuperHeroState(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(this.name),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {},
                child: Container(
                  height: 40,
                  width: 40,
                  child: avatarOrIcon(),
                ))
          ],
        ),
        body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
              future: getHero(id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red[600]),
                          strokeWidth: 5.0,
                        ),
                      ),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return Container(
                        child: Text("Erro ao carregar os dados!"),
                      );
                    } else {
                      return Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                 Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child: CachedNetworkImage(
                                    imageUrl: heroImageUrl,
                                    fit: BoxFit.fill,
                                    height: 300,
                                  )),
                                  Text('$name',
                                      style: TextStyle(
                                        fontSize: 25,
                                      )),
                                  Text('$descriptionHero',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ],
                              )));
                    }
                }
              }),
        )));
  }
}
