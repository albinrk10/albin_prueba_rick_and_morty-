import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/models/character_mode.dart';
import 'package:prueba/providers/api_provider.dart';




class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.name!),
      ),
      body: FutureBuilder<Character>(
        future: apiProvider.getCharacterDetails(character.id!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final characterDetails = snapshot.data!;
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.35,
                  width: double.infinity,
                  child: Hero(
                    tag: characterDetails.id!,
                    child: Image.network(
                      characterDetails.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: size.height * 0.14,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      cardData("Status:", characterDetails.status!),
                      cardData("Specie:", characterDetails.species!),
                      cardData("Origin:", characterDetails.origin!.name!),
                    ],
                  ),
                ),
                const Text(
                  'Episodes',
                  style: TextStyle(fontSize: 17),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: characterDetails.episode!.length,
                    itemBuilder: (context, index) {
                      final episode = characterDetails.episode![index];
                      return ListTile(
                        title: Text(episode.name!),
                        subtitle: Text(episode.airDate!),
                        trailing: Text(episode.episode!),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cardData(String text1, String text2) {
    return Expanded(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(text1),
            Text(
              text2,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}