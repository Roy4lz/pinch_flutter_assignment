import 'dart:io';
import 'package:dio/dio.dart';
import '../domain/models/remote/game_data.dart';
import '../utils/constants.dart';
import 'abstract/abstract_games_list_provider.dart';

class GamesListProvider extends AbstractGamesListProvider {
  @override
  Future<List<GameData?>?> fetchGames(int offset) async {
    Map<String, dynamic> _headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Client-ID"    : API.clientID,
      "Authorization": "Bearer ${API.bearerToken}"
    };

    DateTime _now = DateTime.now();
    int _epochTime = (_now.millisecondsSinceEpoch / 1000).round();

    String _body = "fields cover.image_id,name,rating,first_release_date,summary,storyline;"
          "limit 25;"
          "offset $offset;"
          "where first_release_date != null &"
          "first_release_date < $_epochTime &"
          "rating != null & cover != null;"
          "sort first_release_date desc;";

    final _response = await Dio().post(
      API.gamesListUrl,
      data: _body,
      options: Options(
        headers: _headers,
        responseType: ResponseType.plain,
      ),
    );

    return _response.statusCode == 200 ? gamesListDataFromJson(_response.data) : null;
  }
}