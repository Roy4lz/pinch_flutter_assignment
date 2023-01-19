import 'package:dio/dio.dart';
import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';
import 'package:flutter_pinch_assignment/domain/database/database.dart';
import 'package:flutter_pinch_assignment/domain/models/remote/game_data.dart';

import '../domain/database/dao/game_dao.dart';
import '../utils/tools.dart';

class GameDbService {

  late GamesDatabase _database;
  late GamesDao _gamesDao;

  GameDbService() {
    init();
  }

  Future<GameDbService> init() async{
   _database = await $FloorGamesDatabase.databaseBuilder('games.db').build();
   _gamesDao = _database.gamesDao;
   return this;
  }

  Future<List<GameEntity>> getGames(int offset) async {
    final List<GameEntity> _allGames = await _gamesDao.getGames(offset);
    return _allGames;
  }

  Future<bool> addGames(List<GameData?> games) async {
    // e!.cover.imageId!
    await Future.wait(
        games.map((e) => Tools.getImageBytesFromId(e!.cover.imageId!))
    ).then((imageBytes) => {
      for(int i = 0; i < imageBytes.length; i++){
        _gamesDao.insertGame(GameEntity(games[i]!.id!, games[i]!.name, games[i]!.releaseDate, imageBytes[i].data, games[i]!.summary, games[i]!.storyline, games[i]!.rating))
      }
    });

    return true;
  }

  Future<void> deleteAllGames() async {
    _gamesDao.deleteAllGames();
  }
}