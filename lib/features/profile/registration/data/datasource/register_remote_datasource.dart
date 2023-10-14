import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:soc_app/core/firebase/firebase_auth_client.dart';
import 'package:soc_app/core/firebase/firebase_storage_client.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';

abstract class RegisterRemoteDataSource {
  Future<UserData> createUser(UserData data);
}

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final FirebaseAuthClient _firebaseAuthClient = FirebaseAuthClient();
  final FirabaseStorageClient _firebaseStorageClient = FirabaseStorageClient();
  @override
  Future<UserData> createUser(UserData data) async {
    // create user to firebaseAuth
    // await _firebaseAuthClient.createUser(
    //   email: data.email,
    //   password: data.password,
    // );

    if (data.picPath != null) {
      final file = File(data.picPath!);
      await _firebaseStorageClient.uploadAvatars(file, 'avatars');
    }

    return data;
  }
}
