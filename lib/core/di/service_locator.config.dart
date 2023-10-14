// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i5;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i7;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i6;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i3;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i4;

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
    gh.factory<_i3.CreateUser>(() => _i3.CreateUser());
    gh.lazySingleton<_i4.RegisterCubit>(() => _i4.RegisterCubit());
    gh.lazySingleton<_i5.RegisterRemoteDataSource>(
        () => _i5.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i6.RegisterRepository>(
        () => _i7.RegisterRepositoryImpl(gh<_i5.RegisterRemoteDataSource>()));
    return this;
  }
}
