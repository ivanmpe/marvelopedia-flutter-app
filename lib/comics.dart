import 'package:flutter/material.dart';
import 'package:marvelopedia_flutter_app/api/comic-api.dart';
import 'package:marvelopedia_flutter_app/profile.dart';
import 'package:marvelopedia_flutter_app/sign_in.dart';
import 'package:toast/toast.dart';
import 'comic.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Comics extends StatefulWidget {
  @override
  _ComicsState createState() => _ComicsState();
}

class _ComicsState extends State<Comics> {

  @override
  void initState() {
    super.initState();
    getComics();
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                child: avatarOrIcon(),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      searchComic = text;
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
                  future: getComics(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      /* return this._shimmer(); */
                      case ConnectionState.none:
                        return Container(
                          width: 100,
                          height: 130,
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

  Widget _createComicTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemCount: snapshot.data["data"]["results"].length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              int id = snapshot.data["data"]["results"][index]["id"];
              String title = snapshot.data["data"]["results"][index]["title"];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Comic(id: id, title: title)),
              );
            },
            child: CachedNetworkImage(
              imageUrl:
                  '${snapshot.data["data"]["results"][index]["thumbnail"]["path"]}/portrait_xlarge.${snapshot.data["data"]["results"][index]["thumbnail"]["extension"]}',
              fit: BoxFit.fill,
            ),
          );
        });
  }
}
