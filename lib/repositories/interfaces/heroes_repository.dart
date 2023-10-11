import 'package:auth_apis/models/hero_model.dart';

abstract class HeroesRepository {
  Future<HeroModel> getHeroes({int offset});
}
