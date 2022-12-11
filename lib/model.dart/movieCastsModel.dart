// To parse this JSON data, do
//
//     final castResponse = castResponseFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

CastResponse castResponseFromJson(String str) =>
    CastResponse.fromJson(json.decode(str));

String castResponseToJson(CastResponse data) => json.encode(data.toJson());

class CastResponse {
  CastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<CastResult> cast;
  List<CastResult> crew;

  factory CastResponse.fromJson(Map<String, dynamic> json) => CastResponse(
        id: json["id"],
        cast: List<CastResult>.from(
            json["cast"].map((x) => CastResult.fromJson(x))),
        crew: List<CastResult>.from(
            json["crew"].map((x) => CastResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class CastResult {
  CastResult({
    this.adult,
    this.gender,
    this.id,
    required this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  bool? adult;
  int? gender;
  int? id;
  String name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? job;

  factory CastResult.fromJson(Map<String, dynamic> json) => CastResult(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "job": job,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}
