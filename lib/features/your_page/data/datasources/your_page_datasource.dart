import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/features/post/data/models/post_model.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

abstract class YourPageDataSource {
  // this should return the posts
  // otherwise, throw error.
  Future<List<Post>> getYourPage();
}

@LazySingleton(as: YourPageDataSource)
class YourPageDataSourceImpl implements YourPageDataSource {
  final _graphQLModule = getIt<GraphQLModule>();

  @override
  Future<List<Post>> getYourPage() async {
    String authUid = '';
    var box = await Hive.openBox('userStatus');
    authUid = box.get('userUid');

    // first, query to get all the lists of the user's following
    String query = """
    query MyQuery {
      users(where: {auth_uid: {_eq: "$authUid"}}) {
        following
      }
    }
    """;
    final api1 = await _graphQLModule.queryMethod(query);

    // add user's uid so we can quiery its posts too
    List<String> listFollowing = [authUid];

    // put uid(s) in a list of String
    if (api1['users'][0]['following'] != null) {
      var listOfFollowing = api1['users'][0]['following']
          .map<String>((e) => e.toString())
          .toList();

      listFollowing.addAll(listOfFollowing);
    }

    // then, query get posts from all user's following and user's posts too
    String queryGetPosts = """
    query MyQuery {
      posts(where: {user_id: {_in: $listFollowing}}, order_by: {created_at: desc_nulls_last}) {
        id
        caption
        post_pic
        tags
        username
        user_id
      }
    }
    """;

    final api2 = await _graphQLModule.queryMethod(queryGetPosts);

    List<Post> result =
        api2['posts'].map<Post>((json) => PostModel.fromJson(json)).toList();

    return result;
  }
}
