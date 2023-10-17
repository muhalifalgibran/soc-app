import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/firebase/firebase_storage_client.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(Post post);
  Future<void> getPosts(String userId);
  Future<List<String>> getTags(String username);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final _graphQLModule = getIt<GraphQLModule>();
  final _firebaseStorageClient = FirabaseStorageClient();

  @override
  Future<void> createPost(Post post) async {
    final file = File(post.postPic);
    // save the picture to firebase store and put it by userId
    await _firebaseStorageClient
        .uploadAvatars(file, 'posts/${post.userId}')
        .then((downloadUrl) async {
      // save to Hasura after complete upload the pic
      var mutation = """mutation MyMutation {
      insert_posts(objects: {caption: "${post.caption}", post_pic: "$downloadUrl", tags: ${post.tags}, user_id: "${post.userId}", username: "${post.username}"}) {
            returning {
              id
            }
          }
        }
      """;
      await _graphQLModule.mutateMethod(mutation);
    });
  }

  @override
  Future<void> getPosts(String userId) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTags(String username) async {
    String query = """query MyQuery {
        users(where: {username: {_iregex: "$username"}}) {
          username
        }
      }

    """;
    final result = await _graphQLModule.queryMethod(query);
    print(result['users'].map((e) => e['username'].toString()).toList());
    return result['users']
        .map<String>((e) => e['username'].toString())
        .toList();
  }
}
