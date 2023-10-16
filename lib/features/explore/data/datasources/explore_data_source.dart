import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/features/profile/registration/data/model/user_model.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class ExploreDataSource {
  Future<List<SocUser>> getUsers();
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
}
