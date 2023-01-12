import 'package:flutter/material.dart';
import 'package:flutter_poke_list/services/pokedex_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexService().getPokemonsList(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      List<dynamic> pokemons = snapshot.data['results'];
      return ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              _capitalizeString(pokemons[index]['name']))
              ,
          ) ;
        },
      );
      },
    );
  }

  String _capitalizeString(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}