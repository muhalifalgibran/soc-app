import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/features/profile/registration/data/model/user_model.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class ExploreDataSource {
  Future<List<SocUser>> getUsers();
  Future<void> follow(String targetUserId);
}

@LazySingleton(as: ExploreDataSource)
class ExploreDataSourceImpl implements ExploreDataSource {
  final _module = getIt<GraphQLModule>();

  @override
  Future<List<SocUser>> getUsers() async {
    var box = await Hive.openBox('userStatus');
    var userId = box.get('userUid');
    // box.close();
    var query = """query MyQuery {
      users(where: {_not: {auth_uid: {_eq: "$userId"}}}) {
        username
        post
        pic_url
        id
        following
        followee
        email
        auth_uid
      }
    }
      """;

    final api = await _module.queryMethod(query);

    return api['users'].map<SocUser>((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<void> follow(String targetUserId) async {
    var box = await Hive.openBox('userStatus');
    var userId = box.get('userUid');

    // get the following of the current user
    final queryCurrentUserGetFollowing = """
      query MyQuery {
      users(where: {auth_uid: {_eq: "$userId"}}) {
        following
      }
    }
      """;
    final api1 = await _module.queryMethod(queryCurrentUserGetFollowing);
    List<String> followingCurrentUser =
        api1['users'].map((e) => e['following'] ?? '').toList();
    // append target user id
    followingCurrentUser.add(targetUserId);

    // get the followers of the target user
    final queryTargetUserGetFollowing = """
      query MyQuery {
      users(where: {auth_uid: {_eq: "$targetUserId"}}) {
        following
      }
    }
      """;
    final api2 = await _module.queryMethod(queryTargetUserGetFollowing);
    List<String> followerTargetUser =
        api1['users'].map((e) => e['following'] ?? '').toList();
    // append current user id
    followerTargetUser.add(userId);

    // insert new following of the current user
    final mutateCurrentUser = """
    mutation MyMutation {
      update_users(_set: {following: "$followingCurrentUser"}, where: {auth_uid: {{_eq: "$userId"}}})
    }
  """;
    final api3 = await _module.mutateMethod(mutateCurrentUser);

    // insert new followers to the target user
    final mutateTargetUser = """
    mutation MyMutation {
      update_users(_set: {following: "$followerTargetUser"}, where: {auth_uid: {{_eq: "$targetUserId"}}})
    }
    """;
    final api4 = await _module.mutateMethod(mutateTargetUser);
  }
}
