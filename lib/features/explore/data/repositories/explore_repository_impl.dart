import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/data/datasources/explore_data_source.dart';
import 'package:soc_app/features/explore/domain/repositories/explore_repository.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final _dataSource = getIt<ExploreDataSource>();
  @override
  Future<Either<Failure, List<SocUser>>> getUsers() async {
    try {
      final result = await _dataSource.getUsers();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
