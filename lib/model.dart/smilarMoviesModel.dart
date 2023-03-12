// To parse this JSON data, do
//
//     final similarMoviesModel = similarMoviesModelFromJson(jsonString);

import 'dart:convert';

SimilarMoviesModel similarMoviesModelFromJson(String str) =>
    SimilarMoviesModel.fromJson(json.decode(str));

String similarMoviesModelToJson(SimilarMoviesModel data) =>
    json.encode(data.toJson());

class SimilarMoviesModel {
  SimilarMoviesModel({
    required this.page,
    required this.similarmovieresults,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<SimilarMovieResult> similarmovieresults;
  int totalPages;
  int totalResults;

  factory SimilarMoviesModel.fromJson(Map<String, dynamic> json) =>
      SimilarMoviesModel(
        page: json["page"],
        similarmovieresults: List<SimilarMovieResult>.from(
            json["results"].map((x) => SimilarMovieResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results":
            List<dynamic>.from(similarmovieresults.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class SimilarMovieResult {
  SimilarMovieResult({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage? originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory SimilarMovieResult.fromJson(Map<String, dynamic> json) =>
      SimilarMovieResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage { EN, RU, PT, DE }

final originalLanguageValues = EnumValues({
  "de": OriginalLanguage.DE,
  "en": OriginalLanguage.EN,
  "pt": OriginalLanguage.PT,
  "ru": OriginalLanguage.RU
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
