import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba/network/graphql_client.dart';
import 'package:prueba/models/character_mode.dart';



class ApiProvider with ChangeNotifier {
  List<Character> characters = [];

  Future<void> getCharacters(int page) async {
    const String query = '''
    query GetCharacters(\$page: Int!) {
      characters(page: \$page) {
        results {
          id
          name
          status
          species
          type
          gender
          image
          created
        }
      }
    }
    ''';

    final GraphQLClient client = GraphQLConfig.client.value;
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'page': page},
    );

    final result = await client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    final List<dynamic> data = result.data!['characters']['results'];
    characters.addAll(data.map((json) => Character.fromJson(json)).toList());
    notifyListeners();
  }

  Future<Character> getCharacterDetails(String id) async {
    const String query = '''
    query GetCharacterDetails(\$id: ID!) {
      character(id: \$id) {
        id
        name
        status
        species
        type
        gender
        image
        created
        origin {
          id
          name
          type
          dimension
          created
        }
        episode {
          id
          name
          air_date
          episode
          created
        }
      }
    }
    ''';

    final GraphQLClient client = GraphQLConfig.client.value;
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'id': id},
    );

    final result = await client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    return Character.fromJson(result.data!['character']);
  }

  Future<List<Character>> searchCharacter(String name) async {
    const String query = '''
    query SearchCharacter(\$name: String!) {
      characters(filter: { name: \$name }) {
        results {
          id
          name
          status
          species
          image
        }
      }
    }
    ''';

    final GraphQLClient client = GraphQLConfig.client.value;
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'name': name},
    );

    final result = await client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    final List<dynamic> data = result.data!['characters']['results'];
    return data.map((json) => Character.fromJson(json)).toList();
  }
}