import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:soc_app/core/network/graphql_config.dart';

abstract class GraphQLModule {
  Future<dynamic> queryMethod(String query, {Map<String, dynamic>? variables});
  Future<dynamic> mutateMethod(String mutation,
      {Map<String, dynamic>? variables});
}

class GraphQLModuleImpl extends GraphQLModule {
  static final GraphQLConfig _config = GraphQLConfig();
  final GraphQLClient _client = _config.client();

  @override
  Future<Map<String, dynamic>> queryMethod(String query,
      {Map<String, dynamic>? variables}) async {
    try {
      QueryResult result = await _client.query(
        QueryOptions(
          document: gql(query),
          variables: variables ?? {},
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }
      return result.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future mutateMethod(String mutation,
      {Map<String, dynamic>? variables}) async {
    try {
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: variables ?? {},
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }
      return result.data!;
    } catch (e) {
      throw Exception(e);
    }
  }
}
