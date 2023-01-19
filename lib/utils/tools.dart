import 'package:dio/dio.dart';

class Tools {
  static Future getImageBytesFromId(String id) {
    return Dio().get(
        'https://images.igdb.com/igdb/image/upload/t_cover_big/${id}.jpg',
        options: Options(responseType: ResponseType.bytes)
    );
  }
}