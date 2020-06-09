import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'comic.dart';

class Comics extends StatefulWidget {
  @override
  _ComicsState createState() => _ComicsState();
}

class _ComicsState extends State<Comics> {
  String _comics;
  String apikey = "f0f9dbea302f60ec236962eadd11af09";
  int _offset = 0;
  String _search = "";

  @override
  void initState() {
    super.initState();
    _getComics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quadrinhos"),
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
                  onChanged: (text) {
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
                    labelText: "Pesquise um quadrinho",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _getComics(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return this._shimmer();
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
                          return _createComicTable(context, snapshot);
                        }
                    }
                  }),
            ),
          ],
        ));
  }

  int getCount(List data) {
    if (_comics == null || _comics.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createComicTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10),
        itemCount: snapshot.data["data"]["results"].length,
        itemBuilder: (context, index) {
          //gesture detector serve para deixar a imagem clicavel
          return GestureDetector(
            onTap: () {
              int id = snapshot.data["data"]["results"][index]["id"];

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Comic(id: id)),
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

  Future<Map> _getComics() async {
    await Future.delayed(Duration(seconds: 3));

    http.Response response;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    String temp =
        "${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
    String hash = generateMd5(temp);
    int limit = 20;

    if (_search == "") {
      response = await http
          .get(
              "https://gateway.marvel.com:443/v1/public/comics?ts=$timestamp&orderBy=title&offset=$_offset&apikey=$apikey&limit=$limit&hash=$hash")
          .catchError((error) {
        this.errorToast();
      });
    } else {
      response = await http.get(
          "https://gateway.marvel.com:443/v1/public/comics?ts=$timestamp&orderBy=title&titleStartsWith=$_search&apikey=$apikey&limit=$limit&hash=$hash");
    }

    return json.decode(response.body);
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void errorToast() {
    Toast.show("Erro ao carregar os dados. Verifique sua conexão com internet.", context,
        duration: 2, gravity: Toast.BOTTOM);
  }

  Widget _shimmer() {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10),
        itemCount: 10,
        itemBuilder: (context, index) {
          //gesture detector serve para deixar a imagem clicavel
          return GestureDetector(
            child: Shimmer.fromColors(
              child: Container(
                height: 700.0,
                width: 500.0,
                color: Colors.white,
              ),
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
            ),
          );
        });

    /* SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ); */
  }
}
