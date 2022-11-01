// ignore: file_names
import 'dart:convert';
import 'package:flutter_movieapp/model.dart/NowPlayingModel.dart';
import 'package:http/http.dart' as http;

class API {
  String apiKey = '2b6e3af0b577423063b6a6e271986215';
  static String mainurl = "https://api.themoviedb.org/3";

  var getTrendingmoivesUrl = '$mainurl/trending/movie/week';
  var getPopularUrl = '$mainurl/movie/top_rated';
  var getMoviesUrl = '$mainurl/discover/movie';
  var getnowPlayingUrl = '$mainurl/movie/now_playing';
  var getGenereUrl = '$mainurl/genre/movie/list';
  var getPersonsUrl = '$mainurl/trending/person/week';

  //fething Now playing movies
  Future<List<Result>?> fetchNowPlayingMovies() async {
    var url =
        Uri.parse('$getnowPlayingUrl?api_key=2b6e3af0b577423063b6a6e271986215');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return nowPlayingmoviesFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }
}
