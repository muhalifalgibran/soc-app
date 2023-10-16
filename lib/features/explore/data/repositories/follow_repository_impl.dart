import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/data/datasources/explore_data_source.dart';
import 'package:soc_app/features/explore/domain/repositories/follow_repository.dart';

@LazySingleton(as: FollowRepository)
class FollowRepositoryImpl implements FollowRepository {
  final _datasource = getIt<ExploreDataSource>();
  @override
  Future<Either<Failure, void>> follow(String targetUser) async {
    try {
      final result = await _datasource.follow(targetUser);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollow(String targetUser) async {
    try {
      final result = await _datasource.unfollow(targetUser);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
