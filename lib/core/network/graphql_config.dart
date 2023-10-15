import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
      'https://closing-moray-14.hasura.app/v1/graphql',
      defaultHeaders: {
        "x-hasura-admin-secret":
            'IDSS2Lonz9369KWkJZmdNRFjExVxqK2IdB7cJIN5NCGfGlReMlV2iEpORZkAbke9'
      });

  GraphQLClient client() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
