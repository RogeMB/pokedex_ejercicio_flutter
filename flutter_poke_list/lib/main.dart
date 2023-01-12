import 'package:flutter/material.dart';
import 'package:flutter_poke_list/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('POKEDEX'),
        ),
        body: const HomePage(),
      ),
    );
  }
}
