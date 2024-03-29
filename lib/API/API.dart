// ignore: file_names
import 'dart:convert';
import 'package:flutter_movieapp/model.dart/genersListModel.dart';
import 'package:flutter_movieapp/model.dart/genersMoviesModel.dart';
import 'package:flutter_movieapp/model.dart/movieCastsModel.dart';
import 'package:flutter_movieapp/model.dart/movieTrailerModel.dart';
import 'package:flutter_movieapp/model.dart/moviesdetailsModel.dart';
import 'package:flutter_movieapp/model.dart/nowPlayingModel.dart';
import 'package:flutter_movieapp/model.dart/searchResultModel.dart';
import 'package:flutter_movieapp/model.dart/smilarMoviesModel.dart';
import 'package:flutter_movieapp/model.dart/trendingMoviesModel.dart';
import 'package:flutter_movieapp/model.dart/topRatedMoviesModel.dart';
import 'package:http/http.dart' as http;

class API {
  String apiKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXX';
  static String mainurl = "https://api.themoviedb.org/3";

  var getTrendingmoivesUrl = '$mainurl/trending/movie/week';
  var getTopRatedUrl = '$mainurl/movie/top_rated';
  var getMoviesUrl = '$mainurl/discover/movie';
  var getnowPlayingUrl = '$mainurl/movie/now_playing';
  var getGenereUrl = '$mainurl/genre/movie/list';
  var getPersonsUrl = '$mainurl/trending/person/week';
  var getMoviesdetailsUrl = '$mainurl/movie';
  var getSearchMovieResultUrl = '$mainurl/search/movie';

  //fething Now playing movies
  Future<List<NowPlayingMoviesResult>?> fetchNowPlayingMovies() async {
    var url = Uri.parse('$getnowPlayingUrl?api_key=$apiKey');
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
    var url = Uri.parse('$getTrendingmoivesUrl?api_key=$apiKey');
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
    var url = Uri.parse('$getTopRatedUrl?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return topRatedMoviesModelFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<GenersListResult>?> fetchGeneresList() async {
    var url = Uri.parse('$getGenereUrl?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return generesListFromJson(response.body).genres.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<GenersMoviesResult>?> fetchGeneresMovies(int id) async {
    var url = Uri.parse('$getMoviesUrl?api_key=$apiKey&with_genres=$id');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return genersMoviesModelFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<MoviesdetailsResponse> fetchMoviesDetails(int id) async {
    var url = Uri.parse('$getMoviesdetailsUrl/$id?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return trendingMoviesResponseFromJson(response.body);
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<CastResult>?> fetchCast(int id) async {
    var url = Uri.parse('$getMoviesdetailsUrl/$id/credits?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return castResponseFromJson(response.body).cast.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<MovieTrailerResult>?> fetchTrailer(int id) async {
    var url = Uri.parse('$mainurl/movie/$id/videos?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return movieTrailerResponseModelFromJson(response.body).moviTrailerResult;
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<SearchMoiveResult>> fetchSearchResult(String movieName) async {
    var url = Uri.parse(
        '$getSearchMovieResultUrl?api_key=$apiKey&language=en-US&query=$movieName&page=1&include_adult=false');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return searchResultFromJson(response.body).results.toList();
    } else {
      throw Exception("notfetched");
    }
  }

  Future<List<SimilarMovieResult>> fetchSimilarmovies(int id) async {
    var url = Uri.parse('$mainurl/movie/$id/similar?api_key=$apiKey');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return similarMoviesModelFromJson(response.body)
          .similarmovieresults
          .toList();
    } else {
      throw Exception("notfetched");
    }
  }
}
