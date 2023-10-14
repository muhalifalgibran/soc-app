import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/features/profile/registration/data/datasource/register_remote_datasource.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/register_repository.dart';

// treat the repository as DAO
@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this.dataSource);
  final RegisterRemoteDataSource dataSource;

  @override
  Future<Either<Failure, UserData>> createUser(UserData userData) async {
    try {
      final result = await dataSource.createUser(userData);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
