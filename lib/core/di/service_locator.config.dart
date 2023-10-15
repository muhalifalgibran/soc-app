// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i6;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i11;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i8;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i13;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i7;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i12;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i3;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i9;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i5;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i10;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i14;
import '../network/graphql_module.dart' as _i4;
import 'register_module.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.CreateUser>(() => _i3.CreateUser());
    gh.singleton<_i4.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i5.LoginCubit>(() => _i5.LoginCubit());
    gh.lazySingleton<_i6.LoginRemoteDataSource>(
        () => _i6.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i7.LoginRepository>(() => _i8.LoginRepositoryImpl());
    gh.factory<_i9.LoginUser>(() => _i9.LoginUser());
    gh.lazySingleton<_i10.RegisterCubit>(() => _i10.RegisterCubit());
    gh.lazySingleton<_i11.RegisterRemoteDataSource>(
        () => _i11.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i12.RegisterRepository>(
        () => _i13.RegisterRepositoryImpl(gh<_i11.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i14.StartupCubit>(() => _i14.StartupCubit());
    return this;
  }
}

class _$RegisterModule extends _i15.RegisterModule {}
