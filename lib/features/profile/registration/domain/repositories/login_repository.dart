import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, void>> logout();
}
