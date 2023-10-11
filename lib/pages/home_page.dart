import 'package:auth_apis/pages/heroes_list.dart';
import 'package:auth_apis/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marvel Heroes'),
        ),
        drawer: const CustomDrawer(),
        body: const HeroesList(),
      ),
    );
  }
}