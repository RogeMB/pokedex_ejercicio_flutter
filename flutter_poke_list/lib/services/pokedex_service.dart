import 'package:dio/dio.dart';
import 'package:flutter_poke_list/models/pokemon_list_response_model.dart';
import 'package:flutter_poke_list/models/pokemon_details_model.dart';

class PokedexService {
  final _dio = Dio();
  String url = 'https://pokeapi.co/api/v2';

  Future<List<dynamic>?> getPokemonsList() async {
    try {
      final Response response =
          await _dio.get('$url/pokemon?limit=50&offset=0');
      final PokemonListResponse pokemonListResponse =
          PokemonListResponse.fromJson(response.data);
      final List<Pokemon> pokemonList = pokemonListResponse.results!;

      return pokemonList;
    } 
    catch (e) {
      rethrow;
    }
  }

  Future<PokemonDetails?> getPokemonDetails(String name) async {
    try {
      final Response response = await _dio.get('$url/pokemon/$name');
      final PokemonDetails pokemonDetails =
          PokemonDetails.fromJson(response.data);
      return pokemonDetails;
    } 
    catch (e) {
      rethrow;
    }
  }
}
