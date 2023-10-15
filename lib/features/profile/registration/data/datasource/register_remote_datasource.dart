import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/firebase/firebase_auth_client.dart';
import 'package:soc_app/core/firebase/firebase_storage_client.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/features/profile/registration/data/model/user_model.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class RegisterRemoteDataSource {
  Future<SocUser> createUser(UserData data);
}

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final _firebaseAuthClient = FirebaseAuthClient();
  final _firebaseStorageClient = FirabaseStorageClient();
  final _graphQLModule = getIt<GraphQLModule>();
  @override
  Future<SocUser> createUser(UserData data) async {
    String downloadUrl = '';
    // create user to firebaseAuth
    late SocUser user;
    await _firebaseAuthClient
        .createUser(
      email: data.email,
      password: data.password,
    )
        .then((credential) async {
      // make sure the auth is done, then
      // get user uid for the id in db
      // upload the avatar
      if (data.picPath != null) {
        final file = File(data.picPath!);
        downloadUrl =
            await _firebaseStorageClient.uploadAvatars(file, 'avatars');
      }
      // insert to graphQL

      var mutation = """mutation MyMutation {
        insert_users(objects: {auth_uid: "${credential.user?.uid}" ,email: "${data.email}", pic_url: "$downloadUrl", username: "${data.username}"}) {
          returning {
            email
            followee
            following
            id
            pic_url
            username
          }
        }
      }""";
      var call = await _graphQLModule.mutateMethod(mutation);
      var result = UserModel.fromJson(call['insert_users']['returning'][0]);
      user = result;
    });
    // throw Exception();

    return user;
  }
}
