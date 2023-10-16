import 'package:dartz/dartz.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

import '../../../../core/error/failure.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<SocUser>>> getUsers();
}
