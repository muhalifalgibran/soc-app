import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/data/datasource/login_remote_datasource.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/login_repository.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final _dataSource = getIt<LoginRemoteDataSource>();

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final result = await _dataSource.login(email, password);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await _dataSource.logout();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
