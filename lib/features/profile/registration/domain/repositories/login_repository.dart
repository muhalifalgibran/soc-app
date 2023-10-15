import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> login(String email, String password);
}
