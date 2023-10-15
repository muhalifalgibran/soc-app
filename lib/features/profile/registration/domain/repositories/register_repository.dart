import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class RegisterRepository {
  Future<Either<Failure, SocUser>> createUser(UserData userData);
}
