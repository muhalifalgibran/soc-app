import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/features/post/data/models/post_model.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/data/model/user_model.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class ProfileRemoteDataSource {
  Future<SocUser> getUserProfile();
  Future<List<Post>> getPosts(String userId);
}

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final _module = getIt<GraphQLModule>();
  @override
  Future<SocUser> getUserProfile() async {
    var box = await Hive.openBox('userStatus');
    var authUid = box.get('userUid');
    // box.close();

    var query = """query MyQuery {
      users(where: {auth_uid: {_eq: "$authUid"}}) {
        email
        followee
        following
        pic_url
        id
        post
        username
      }
    }
    """;

    final res = await _module.queryMethod(query);

    return UserModel.fromJson(res['users'][0]);
  }

  @override
  Future<List<Post>> getPosts(String userId) async {
    // get your posts order by the newest post
    var query = """query MyQuery {
      posts(where: {user_id: {_eq: "$userId"}}, order_by: {created_at: desc_nulls_last}) {
        post_pic
        tags
        id
        caption
        user_id
      }
    }
    """;

    final res = await _module.queryMethod(query);
    List<Post> result =
        res['posts'].map<Post>((e) => PostModel.fromJson(e)).toList();
    return result;
  }
}
