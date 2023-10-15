import 'package:injectable/injectable.dart';
import 'package:soc_app/core/firebase/firebase_auth_client.dart';

abstract class LoginRemoteDataSource {
  Future<void> login(String email, String password);
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final _firebaseAuthClient = FirebaseAuthClient();

  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuthClient.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
