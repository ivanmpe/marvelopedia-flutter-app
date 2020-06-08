import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:marvelopedia_flutter_app/comic.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'hero.dart';

class Heroes extends StatefulWidget {
  @override
  _HeroesState createState() => _HeroesState();
}

class _HeroesState extends State<Heroes> {
  String _heroes;
  String apikey = "f0f9dbea302f60ec236962eadd11af09";
  int _offset = 0;
  String _search;

  @override
  void initState() {
    super.initState();
    _getHeroes().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Heróis"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red[500],
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
            Container(
              height: 70,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onSubmitted: (text) {
                    setState(() {
                      _search = text;
                    });
                  },
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 28.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Pesquise um heróis",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _getHeroes(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red[600]),
                            strokeWidth: 5.0,
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
                          return _createHeroTable(context, snapshot);
                        }
                    }
                  }),
            ),
          ],
        ));
  }

  Future<Map> _getHeroes() async {
    http.Response response;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    String temp =
        "${timestamp}ebd407c102ea3f1262b8dd370cfa04d4a132a867d8b23f3429d72898aaffd1a321761b4a";
    String hash = generateMd5(temp);
    int limit = 20;

    if (_search == null) {
      response = await http.get(
          "https://gateway.marvel.com:443/v1/public/characters?ts=$timestamp&orderBy=title&offset=$_offset&apikey=$apikey&limit=$limit&hash=$hash");
    } else {
      response = await http.get(
          "https://gateway.marvel.com:443/v1/public/characters?ts=$timestamp&orderBy=title&titleStartsWith=$_search&apikey=$apikey&limit=$limit&hash=$hash");
    }

    return json.decode(response.body);
  }

  Widget _createHeroTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10),
        itemCount: snapshot.data["data"]["results"].length,
        itemBuilder: (context, index) {
          //gesture detector serve para deixar a imagem clicavel
          return GestureDetector(
              onTap: (){
                   Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Comic()),
                      );
              },
            child: Image.network(
              '${snapshot.data["data"]["results"][index]["thumbnail"]["path"]}/portrait_xlarge.${snapshot.data["data"]["results"][index]["thumbnail"]["extension"]}',
              height: 700.0,
              fit: BoxFit.fill,
            ),
          );
        });
  }


  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void errorToast() {
    Toast.show("Erro ao carregar os dados", context,
        duration: 2, gravity: Toast.BOTTOM);
  }
}
