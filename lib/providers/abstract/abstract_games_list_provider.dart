import 'package:flutter_pinch_assignment/domain/models/remote/game_data.dart';

abstract class AbstractGamesListProvider {
  Future<List<GameData?>?> fetchGames(int offset);
}