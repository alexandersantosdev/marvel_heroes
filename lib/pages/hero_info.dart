// ignore_for_file: must_be_immutable

import 'package:auth_apis/models/hero_model.dart';
import 'package:flutter/material.dart';

class HeroInfo extends StatefulWidget {
  HeroInfo({super.key, required this.hero});

  Results hero;
  @override
  State<HeroInfo> createState() => _HeroInfoState();
}

class _HeroInfoState extends State<HeroInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.hero.name!)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Image.network(
                    "${widget.hero.thumbnail!.path!}.${widget.hero.thumbnail!.extension!}"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.hero.id} - ${widget.hero.name!}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.hero.description != "" ? widget.hero.description! : "",
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
