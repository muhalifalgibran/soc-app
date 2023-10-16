import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';

abstract class FollowRepository {
  Future<Either<Failure, void>> follow(String targetUser);
  Future<Either<Failure, void>> unfollow(String targetUser);
}
