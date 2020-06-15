import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'api/comic-api.dart';

class Comic extends StatefulWidget {
  final int id;
  final String title;
  Comic({Key key, @required this.id, @required this.title}) : super(key: key);

  @override
  _ComicState createState() => _ComicState(this.id, this.title);
}

class _ComicState extends State<Comic> {
  String title;
  int id;
  _ComicState(this.id, this.title);

  @override
  void initState() {
    super.initState();
    getComic(id);
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
                  future: getComic(id),
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
                                        imageUrl: imageUrl,
                                        fit: BoxFit.fill,
                                        height: 300,
                                      ), 
                                      Text('$title',
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                      Text('Preço: ', style: TextStyle(fontSize: 20),),
                                      Text('$price', style: TextStyle(fontSize: 15),),
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

  void errorToast() {
    Toast.show("Erro ao carregar os dados. Verifique sua conexão com internet.",
        context,
        duration: 2, gravity: Toast.BOTTOM);
  }
}
