// ignore: file_names
import 'dart:convert';
import 'package:flutter_movieapp/model.dart/nowPlayingModel.dart';
import 'package:flutter_movieapp/model.dart/trendingMoviesModel.dart';
import 'package:flutter_movieapp/model.dart/topRatedMoviesModel.dart';
import 'package:http/http.dart' as http;

class API {
  String apiKey = '2b6e3af0b577423063b6a6e271986215';
  static String mainurl = "https://api.themoviedb.org/3";

  var getTrendingmoivesUrl = '$mainurl/trending/movie/week';
  var getTopRatedUrl = '$mainurl/movie/top_rated';
  var getMoviesUrl = '$mainurl/discover/movie';
  var getnowPlayingUrl = '$mainurl/movie/now_playing';
  var getGenereUrl = '$mainurl/genre/movie/list';
  var getPersonsUrl = '$mainurl/trending/person/week';

  //fething Now playing movies
  Future<List<NowPlayingMoviesResult>?> fetchNowPlayingMovies() async {
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

  Future<List<TrendingMoivesResult>?> fetchTrendingMovies() async {
    var url = Uri.parse(
        '$getTrendingmoivesUrl?api_key=2b6e3af0b577423063b6a6e271986215');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return trendingMoviesModelFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<TopRatedMoviesResult>?> fetchTopRatedMovies() async {
    var url =
        Uri.parse('$getTopRatedUrl?api_key=2b6e3af0b577423063b6a6e271986215');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return topRatedMoviesModelFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }
}
