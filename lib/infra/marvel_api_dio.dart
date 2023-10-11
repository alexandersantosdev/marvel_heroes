import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelApiDio {
  final _dio = Dio();

  MarvelApiDio() {
    _dio.options.baseUrl = dotenv.get('API_URL');
  }

  Dio get dio => _dio;
}
