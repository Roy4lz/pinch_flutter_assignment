import 'dart:async';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/game_dao.dart';
import 'entities/game_entity.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [GameEntity])
abstract class GamesDatabase extends FloorDatabase {
  GamesDao get gamesDao;
}