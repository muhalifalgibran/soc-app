import 'package:injectable/injectable.dart';
import 'package:soc_app/core/firebase/firebase_auth_client.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';

abstract class RegisterRemoteDataSource {
  Future<UserData> createUser(UserData data);
}

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final FirebaseAuthClient _firebaseAuthClient = FirebaseAuthClient();
  @override
  Future<UserData> createUser(UserData data) async {
    // create user to firebaseAuth

    await _firebaseAuthClient.createUser(
      email: data.email,
      password: data.password,
    );

    return data;
  }
}
