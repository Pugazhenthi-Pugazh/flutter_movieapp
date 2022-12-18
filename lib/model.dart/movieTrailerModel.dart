// To parse this JSON data, do
//
//     final movieTrailerResponseModel = movieTrailerResponseModelFromJson(jsonString);

import 'dart:convert';

MovieTrailerResponseModel movieTrailerResponseModelFromJson(String str) =>
    MovieTrailerResponseModel.fromJson(json.decode(str));

String movieTrailerResponseModelToJson(MovieTrailerResponseModel data) =>
    json.encode(data.toJson());

class MovieTrailerResponseModel {
  MovieTrailerResponseModel({
    required this.id,
    required this.moviTrailerResult,
  });

  int id;
  List<MovieTrailerResult> moviTrailerResult;

  factory MovieTrailerResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieTrailerResponseModel(
        id: json["id"],
        moviTrailerResult: List<MovieTrailerResult>.from(
            json["results"].map((x) => MovieTrailerResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(moviTrailerResult.map((x) => x.toJson())),
      };
}

class MovieTrailerResult {
  MovieTrailerResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  Iso6391? iso6391;
  Iso31661? iso31661;
  String name;
  String key;
  Site? site;
  int size;
  String type;
  bool official;
  DateTime publishedAt;
  String id;

  factory MovieTrailerResult.fromJson(Map<String, dynamic> json) =>
      MovieTrailerResult(
        iso6391: iso6391Values.map![json["iso_639_1"]],
        iso31661: iso31661Values.map![json["iso_3166_1"]],
        name: json["name"],
        key: json["key"],
        site: siteValues.map![json["site"]],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse![iso6391],
        "iso_3166_1": iso31661Values.reverse![iso31661],
        "name": name,
        "key": key,
        "site": siteValues.reverse![site],
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({"US": Iso31661.US});

enum Iso6391 { EN }

final iso6391Values = EnumValues({"en": Iso6391.EN});

enum Site { YOU_TUBE }

final siteValues = EnumValues({"YouTube": Site.YOU_TUBE});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    // ignore: prefer_conditional_assignment
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
