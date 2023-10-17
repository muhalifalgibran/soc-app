import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/firebase/firebase_auth_client.dart';
import 'package:soc_app/core/network/graphql_module.dart';

abstract class LoginRemoteDataSource {
  Future<String> login(String email, String password);
  Future<void> logout();
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final _firebaseAuthClient = FirebaseAuthClient();

  @override
  Future<String> login(String email, String password) async {
    final result = await _firebaseAuthClient.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user?.uid ?? '';
  }

  @override
  Future<void> logout() async {
    await _firebaseAuthClient.signOut();
  }
}
