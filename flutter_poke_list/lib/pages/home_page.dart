import 'package:flutter/material.dart';
import 'package:flutter_poke_list/models/pokemon_list_response_model.dart';
import 'package:flutter_poke_list/pages/pokemon_details_page.dart';
import 'package:flutter_poke_list/services/pokedex_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _capitalizeString(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexService().getPokemonsList(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Pokemon> pokemons = snapshot.data;
        return ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsPage(
                      name: pokemons[index].name!,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  _capitalizeString(
                    pokemons[index].name!,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
