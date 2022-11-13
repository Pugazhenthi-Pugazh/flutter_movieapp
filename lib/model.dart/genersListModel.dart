// To parse this JSON data, do
//
//     final generesList = generesListFromJson(jsonString);

import 'dart:convert';

GeneresList generesListFromJson(String str) =>
    GeneresList.fromJson(json.decode(str));

String generesListToJson(GeneresList data) => json.encode(data.toJson());

class GeneresList {
  GeneresList({
    required this.genres,
  });

  List<GenersListResult> genres;

  factory GeneresList.fromJson(Map<String, dynamic> json) => GeneresList(
        genres: List<GenersListResult>.from(
            json["genres"].map((x) => GenersListResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class GenersListResult {
  GenersListResult({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory GenersListResult.fromJson(Map<String, dynamic> json) =>
      GenersListResult(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
