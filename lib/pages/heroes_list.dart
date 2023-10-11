import 'package:auth_apis/models/hero_model.dart';
import 'package:auth_apis/pages/hero_info.dart';
import 'package:auth_apis/repositories/impl/heroes_repository_dio.dart';
import 'package:auth_apis/repositories/interfaces/heroes_repository.dart';
import 'package:flutter/material.dart';

class HeroesList extends StatefulWidget {
  const HeroesList({super.key});

  @override
  State<HeroesList> createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  late HeroesRepository _heroesRepository;
  List<Results> _heroes = [];
  int offset = 0;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _heroesRepository = HeroesRepositoryDio();
    _fetchHeroes();
    scrollController.addListener(() {
      if(isLoading) return;
      var toPaginatePosition = scrollController.position.maxScrollExtent * 0.7;
      if (scrollController.position.pixels < toPaginatePosition) {
        offset = offset + 20;
        _fetchHeroes();
      }
    });
  }

  Future<void> _fetchHeroes() async {
    isLoading = true;
    var gheroes = await _heroesRepository.getHeroes(offset: offset);
    _heroes = {..._heroes, ...gheroes.data!.results!}.toList();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          controller: scrollController,
          itemCount: (_heroes.isNotEmpty) ? _heroes.length : 0,
          itemBuilder: (_, int index) {
            var hero = _heroes[index];
            return index + 1 == _heroes.length
                ? isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            offset = offset + 20;
                            _fetchHeroes();
                          });
                        },
                        child: const Text("Load More"))
                : Card(
                    child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeroInfo(
                          hero: hero,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          "${hero.thumbnail!.path!}.${hero.thumbnail!.extension!}",
                          width: 70,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hero.name!),
                            Text((hero.description != "" && hero.description!.length > 20)
                                ? "${hero.description!.substring(0, 20)}..."
                                : ""),
                          ],
                        ),
                      ],
                    ),
                  ));
          }),
    );
  }
}
