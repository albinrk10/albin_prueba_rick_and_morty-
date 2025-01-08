import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



class GraphQLConfig {
  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: HttpLink('https://rickandmortyapi.com/graphql'),
    ),
  );
}
