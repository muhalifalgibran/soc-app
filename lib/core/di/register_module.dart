import 'package:soc_app/features/profile/registration/data/datasource/register_remote_datasource.dart';
import 'package:soc_app/features/profile/registration/data/repositories/register_repository_impl.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  // @injectable
  // RegisterRemoteDataSource get registerRemoteDataSource =>
  //     RegisterRemoteDataSourceImpl();

  // @singleton
  // RegisterRepository get registerRepository =>
  //     RegisterRepositoryImpl(registerRemoteDataSource);
}
