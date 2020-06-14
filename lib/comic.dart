import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:toast/toast.dart';

class Comic extends StatefulWidget {
  final int id;
  final String title;
  Comic({Key key, @required this.id, @required this.title}) : super(key: key);

  @override
  _ComicState createState() => _ComicState(this.id, this.title);
}

class _ComicState extends State<Comic> {
  String description = "";
  String image = "";
  String ext = "";
  String published = "";
  double price = 0.0;

  String title;
  int id;
  _ComicState(this.id, this.title);

  @override
  void initState() {
    super.initState();
    _getComic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          automaticallyImplyLeading: false,
          title: Text('$title'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.person,
                color: Colors.red[600],
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: _getComic(),
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red[600]),
                              strokeWidth: 5.0,
                            ),
                          ),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasError) {
                          errorToast();
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
                                      CachedNetworkImage(
                                        imageUrl: '$image.$ext',
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                      ),
                                      Text('$title',
                                          style: TextStyle(
                                            fontSize: 25,
                                          )),
                                      Text('$price'),
                                      Text('$description',
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                    ],
                                  )));
                        }
                    }
                  }),
            )
          ],
        ));
  }

  Future<bool> _getComic() async {
    http.Response response;
    int id = this.id;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    String temp =
        "${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
    String hash = generateMd5(temp);
    String url =
        "https://gateway.marvel.com:443/v1/public/comics/$id?ts=$timestamp&apikey=f0f9dbea302f60ec236962eadd11af09&hash=$hash";
    response = await http.get(url).catchError((error) {
      return false;
    });

    this.description =
        json.decode(response.body)["data"]["results"][0]["description"];
    this.image =
        json.decode(response.body)["data"]["results"][0]["thumbnail"]["path"];
    this.ext = json.decode(response.body)["data"]["results"][0]["thumbnail"]
        ["extension"];
    return true;
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void errorToast() {
    Toast.show("Erro ao carregar os dados. Verifique sua conexão com internet.",
        context,
        duration: 2, gravity: Toast.BOTTOM);
  }
}
