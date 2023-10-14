import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';

abstract class RegisterRepository {
  Future<Either<Failure, UserData>> createUser(UserData userData);
}
