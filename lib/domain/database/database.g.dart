// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorGamesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GamesDatabaseBuilder databaseBuilder(String name) =>
      _$GamesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GamesDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$GamesDatabaseBuilder(null);
}

class _$GamesDatabaseBuilder {
  _$GamesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$GamesDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$GamesDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<GamesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$GamesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$GamesDatabase extends GamesDatabase {
  _$GamesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GamesDao? _gamesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GameEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `gameId` INTEGER NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `storyline` TEXT NOT NULL, `releaseDate` INTEGER NOT NULL, `coverImage` BLOB NOT NULL, `rating` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GamesDao get gamesDao {
    return _gamesDaoInstance ??= _$GamesDao(database, changeListener);
  }
}

class _$GamesDao extends GamesDao {
  _$GamesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _gameEntityInsertionAdapter = InsertionAdapter(
            database,
            'GameEntity',
            (GameEntity item) => <String, Object?>{
                  'id': item.id,
                  'gameId': item.gameId,
                  'name': item.name,
                  'description': item.description,
                  'storyline': item.storyline,
                  'releaseDate': item.releaseDate,
                  'coverImage': item.coverImage,
                  'rating': item.rating
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GameEntity> _gameEntityInsertionAdapter;

  @override
  Future<List<GameEntity>> getGames(int offset) async {
    return _queryAdapter.queryList('SELECT * FROM GameEntity LIMIT ?1,25',
        mapper: (Map<String, Object?> row) => GameEntity(
            row['gameId'] as int,
            row['name'] as String,
            row['releaseDate'] as int,
            row['coverImage'] as Uint8List,
            row['description'] as String,
            row['storyline'] as String,
            row['rating'] as double),
        arguments: [offset]);
  }

  @override
  Future<void> deleteAllGames() async {
    await _queryAdapter.queryNoReturn('DELETE FROM GameEntity');
  }

  @override
  Future<void> insertGame(GameEntity game) async {
    await _gameEntityInsertionAdapter.insert(game, OnConflictStrategy.ignore);
  }
}
