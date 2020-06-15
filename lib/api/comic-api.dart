import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';

String description = '';
String imageUrl = '';
String price = '';
String searchComic = '';
int offset = 0;

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

Future<bool> getComic(int id) async {
  http.Response response;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  String temp =
      "${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
  String hash = generateMd5(temp);
  String url =
      "https://gateway.marvel.com:443/v1/public/comics/$id?ts=$timestamp&apikey=f0f9dbea302f60ec236962eadd11af09&hash=$hash";
  response = await http.get(url).catchError((error) {
    return false;
  });

  description = json.decode(response.body)["data"]["results"][0]["description"];
  String path =
      json.decode(response.body)["data"]["results"][0]["thumbnail"]["path"];
  String ext = json.decode(response.body)["data"]["results"][0]["thumbnail"]
      ["extension"];
  imageUrl = '$path.$ext';
  price = json.decode(response.body)["data"]["results"][0]["price"];
  return true;
}

Future<Map> getComics() async {
  http.Response response;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  String temp =
      "${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
  String hash = generateMd5(temp);
  int limit = 20;
  String apikey = "f0f9dbea302f60ec236962eadd11af09";

  if (searchComic == "") {
    response = await http.get(
        "https://gateway.marvel.com:443/v1/public/comics?ts=$timestamp&orderBy=title&offset=$offset&apikey=$apikey&limit=$limit&hash=$hash");
  } else {
    response = await http.get(
        "https://gateway.marvel.com:443/v1/public/comics?ts=$timestamp&orderBy=title&titleStartsWith=$searchComic&apikey=$apikey&limit=$limit&hash=$hash");
  }

  return json.decode(response.body);
}


  /* Widget _shimmer() {
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
  } */
