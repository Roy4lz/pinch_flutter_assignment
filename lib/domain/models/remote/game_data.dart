import 'dart:convert';

List<GameData?>? gamesListDataFromJson(String str) => json.decode(str) == null ? [] : List<GameData?>.from(json.decode(str)!.map((x) => GameData.fromJson(x)));

String gamesListDataToJson(List<GameData?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class GameData {
  GameData({
    required this.id,
    required this.cover,
    required this.name,
    required this.rating,
    required this.releaseDate,
    required this.summary,
    required this.storyline,
  });

  final int? id;
  final Cover cover;
  final String name;
  final double rating;
  final int releaseDate;
  final String summary;
  final String storyline;

  factory GameData.fromJson(Map<String, dynamic> json) => GameData(
    id: json["id"],
    cover: Cover.fromJson(json["cover"]),
    name: json["name"] ?? "",
    rating: json["rating"],
    releaseDate: json["first_release_date"],
    summary: json["summary"] ?? "",
    storyline: json["storyline"] ?? "",
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "cover": cover.toJson(),
  "name": name,
  "rating": rating,
  "first_release_date": releaseDate,
  "summary": summary,
  "storyline": storyline,
  };
}

class Cover {
  Cover({
    required this.id,
    required this.imageId,
  });

  final int? id;
  final String? imageId;

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
    id: json["id"],
    imageId: json["image_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_id": imageId,
  };
}
