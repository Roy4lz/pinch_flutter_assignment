import 'dart:typed_data';

import 'package:floor/floor.dart';

@entity
class GameEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int gameId;
  String name;
  String description;
  String storyline;
  int releaseDate;
  Uint8List coverImage;
  double rating;

  GameEntity(this.gameId, this.name, this.releaseDate, this.coverImage, this.description, this.storyline, this.rating);
}