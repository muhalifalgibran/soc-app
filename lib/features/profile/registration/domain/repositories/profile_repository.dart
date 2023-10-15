import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, SocUser>> getProfile();
}
