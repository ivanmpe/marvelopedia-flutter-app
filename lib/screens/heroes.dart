import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvelopedia_flutter_app/api/super-hero-api.dart';
import 'package:marvelopedia_flutter_app/screens/profile.dart';
import 'package:marvelopedia_flutter_app/screens/sign_in.dart';
import 'package:toast/toast.dart';
import 'super-hero.dart';

class Heroes extends StatefulWidget {
  @override
  _HeroesState createState() => _HeroesState();
}

class _HeroesState extends State<Heroes> {
  @override
  void initState() {
    super.initState();
    getHeroes().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Heróis"),
          automaticallyImplyLeading: false,
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
              height: 70,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      searchSuperHero = text;
                      getHeroes();
                    });
                  },
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 28.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Pesquise um heróis",
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getHeroes(),
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
                          if (snapshot.data['data']['results'].length > 0)
                            return _createHeroTable(context, snapshot);

                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Não foram encontrados heróis com essa pesquisa. =( ',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[500],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        }
                    }
                  }),
            ),
          ],
        ));
  }

  Widget _createHeroTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10),
        itemCount: snapshot.data["data"]["results"].length,
        itemBuilder: (context, index) {
          int id = snapshot.data["data"]["results"][index]['id'];
          String name = snapshot.data["data"]["results"][index]['name'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuperHero(id: id, name: name)),
              );
            },
            child: CachedNetworkImage(
              imageUrl:
                  '${snapshot.data["data"]["results"][index]["thumbnail"]["path"]}/portrait_xlarge.${snapshot.data["data"]["results"][index]["thumbnail"]["extension"]}',
              height: 700.0,
              fit: BoxFit.fill,
            ),
          );
        });
  }

  void errorToast() {
    Toast.show("Erro ao carregar os dados", context,
        duration: 2, gravity: Toast.BOTTOM);
  }
}
