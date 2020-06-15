import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

String searchSuperHero = '';
String apikey = "f0f9dbea302f60ec236962eadd11af09";
int _offset = 0;
int limit = 20;

Future<Map> getHeroes() async {
  http.Response response;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  String temp ="${timestamp}c6d627c0a8fb80a61752e031dd30a4d4d2fafffef0f9dbea302f60ec236962eadd11af09";
  String hash = generateMd5(temp);

  if (searchSuperHero == "") {
    try {
      response = await http.get(
          "https://gateway.marvel.com:443/v1/public/characters?ts=$timestamp&orderBy=name&offset=$_offset&apikey=$apikey&limit=$limit&hash=$hash");
    } catch (e) {
      print(e);
    }
  } else {
    response = await http.get(
        "https://gateway.marvel.com:443/v1/public/characters?ts=$timestamp&orderBy=name&nameStartsWith=$searchSuperHero&apikey=$apikey&limit=$limit&hash=$hash");
  }

  return json.decode(response.body);
}

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
