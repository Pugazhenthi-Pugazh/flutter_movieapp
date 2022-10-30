// ignore: file_names
import 'dart:convert';
import 'package:flutter_movieapp/model.dart/NowPlayingModel.dart';
import 'package:http/http.dart' as http;

class API {
  String apiKey = '2b6e3af0b577423063b6a6e271986215';
  static String mainurl = "https://api.themoviedb.org/3";

  fetchMovies() async {
    var url = Uri.parse(
        '$mainurl/movie/now_playing?api_key=2b6e3af0b577423063b6a6e271986215');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var moviedata = json.decode(response.body);
      return moviedata['results'];
    } else {
      throw Exception("notfetched");
    }
  }
}
