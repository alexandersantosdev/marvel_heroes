import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:auth_apis/infra/marvel_api_dio.dart';
import 'package:auth_apis/models/hero_model.dart';
import 'package:auth_apis/repositories/interfaces/heroes_repository.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HeroesRepositoryDio extends HeroesRepository {
  @override
  Future<HeroModel> getHeroes({int offset = 0}) async {
    var marvelApi = MarvelApiDio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = dotenv.get('PUBLIC_KEY');
    var privateKey = dotenv.get('PRIVATE_KEY');
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query =
        "?limit=20&offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";
    var result = await marvelApi.dio.get('/v1/public/characters$query');
    var heroes = HeroModel.fromJson(result.data);
    return heroes;
  }

  _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = crypto.md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
