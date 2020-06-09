import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:toast/toast.dart';

class Comic extends StatefulWidget {
  final int id;
  Comic({Key key, @required this.id}) : super(key: key);

  @override
  _ComicState createState() => _ComicState(this.id);
}

class _ComicState extends State<Comic> {
  String title;
  String description = "";
  String image;
  String ext;
  String published;

  int id;
  _ComicState(this.id);

  @override
  void initState() {
    super.initState();
   _getComic(this.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        automaticallyImplyLeading: false,
        title: Text(this.description),
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
      body: Column(
          children: <Widget>[
              Text(this.title),
              Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
          ],
      ),
    );
  }

  Future _getComic(int id) async {
    http.Response response;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    String temp =
        "${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
    String hash = generateMd5(temp);
    String url =
        "https://gateway.marvel.com:443/v1/public/comics/$id?ts=$timestamp&apikey=f0f9dbea302f60ec236962eadd11af09&hash=$hash";
    response = await http.get(url);
    this.title = json.decode(response.body)["data"]["results"][0]["title"];
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
