import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';
import 'package:flutter_pinch_assignment/services/game_db_service.dart';
import 'package:get_it/get_it.dart';

import '../../providers/abstract/abstract_games_list_provider.dart';

class GamesListRepository {
  GamesListRepository(this.apiProvider);

  final AbstractGamesListProvider apiProvider;
  late List<GameEntity> gamesList;
  final GameDbService _gameDbService = GetIt.I<GameDbService>();

  Future<List<GameEntity>> getGamesList(int offset){
    return apiProvider.fetchGames(offset).then((data) async {
      //Empty database when new data can be retrieved
      if(offset == 0 && data != null){
        _gameDbService.deleteAllGames();
      }

      await _gameDbService.addGames(data!);

      return _gameDbService.getGames(offset).then((localGames) {
        gamesList = localGames;
        return localGames;
      });
    }, onError: (error, stackTrace) {
      print("Something went wrong when retrieving remote so showing local content");
      return _gameDbService.getGames(offset).then((localGames) {
        gamesList = localGames;
        return localGames;
      });
    });
  }
}