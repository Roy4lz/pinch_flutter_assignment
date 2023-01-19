import 'package:floor/floor.dart';
import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';

@dao
abstract class GamesDao {
  @Query('SELECT * FROM GameEntity LIMIT :offset,25')
  Future<List<GameEntity>> getGames(int offset);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertGame(GameEntity game);

  @Query('DELETE FROM GameEntity')
  Future<void> deleteAllGames();
}