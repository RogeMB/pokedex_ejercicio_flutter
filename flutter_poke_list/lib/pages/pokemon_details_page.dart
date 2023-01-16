import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_poke_list/models/pokemon_details_model.dart';
import 'package:flutter_poke_list/services/pokedex_service.dart';

class PokemonDetailsPage extends StatelessWidget {
  final String name;
  const PokemonDetailsPage({
    super.key,
    required this.name,
  });

  String _capitalizeString(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 166, 0),
      appBar: AppBar(title: Text(_capitalizeString(name))),
      body: FutureBuilder(
        future: PokedexService().getPokemonDetails(name),
        initialData: const {},
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          PokemonDetails pokemonDetails = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Opacity(
                        opacity: .5,
                        child: Image.network(
                            pokemonDetails.sprites!.other!.home!.frontDefault!,
                            color: Colors.black)),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Image.network(
                          pokemonDetails.sprites!.other!.home!.frontDefault!,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          frameBuilder: (BuildContext context, Widget child,
                              int? frame, bool wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              _capitalizeString(pokemonDetails.name!),
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Divider(
                            height: 2.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Id: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${pokemonDetails.id}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Type: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...pokemonDetails.types!
                                  .map((e) => Text(
                                        '${_capitalizeString(e.type!.name!)} ',
                                      ))
                                  .toList()
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Height: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${pokemonDetails.height}dm'),
                              const SizedBox(
                                width: 25.0,
                              ),
                              const Text(
                                'Weight: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${pokemonDetails.weight}hg'),
                            ],
                          ),
                          Row(children: [
                            const Text(
                              'Base experience: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(pokemonDetails.baseExperience.toString()),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Stats',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Divider(
                            height: 2.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 5),
                            children: [
                              ...pokemonDetails.stats!
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _capitalizeString(e.stat!.name!),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(e.baseStat.toString()),
                                          ],
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Moves: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Divider(
                            height: 2.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 200.0,
                            width: double.infinity,
                            child: ListView(
                              children: [
                                ...pokemonDetails.moves!
                                    .map((e) => ListTile(
                                          title: Text(
                                            _capitalizeString(e.move!.name!),
                                          ),
                                          subtitle: Text(
                                            'Learned at level ${e.versionGroupDetails![0].levelLearnedAt.toString()}',
                                          ),
                                        ))
                                    .toList()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
