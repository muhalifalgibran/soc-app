// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i13;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i15;
import '../../features/post/domain/repositories/post_repository.dart' as _i14;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i12;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i7;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i18;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i9;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i20;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i8;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i19;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i10;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i11;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i6;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i16;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i17;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i21;
import '../network/graphql_module.dart' as _i5;
import 'register_module.dart' as _i22;

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
    gh.factory<_i3.CreatePost>(() => _i3.CreatePost());
    gh.factory<_i4.CreateUser>(() => _i4.CreateUser());
    gh.singleton<_i5.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i6.LoginCubit>(() => _i6.LoginCubit());
    gh.lazySingleton<_i7.LoginRemoteDataSource>(
        () => _i7.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i8.LoginRepository>(() => _i9.LoginRepositoryImpl());
    gh.factory<_i10.LoginUser>(() => _i10.LoginUser());
    gh.factory<_i11.LogoutUser>(() => _i11.LogoutUser());
    gh.lazySingleton<_i12.PostCubit>(() => _i12.PostCubit());
    gh.lazySingleton<_i13.PostRemoteDataSource>(
        () => _i13.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i14.PostRepository>(() => _i15.PostRepositoryImpl());
    gh.lazySingleton<_i16.ProfileCubit>(() => _i16.ProfileCubit());
    gh.lazySingleton<_i17.RegisterCubit>(() => _i17.RegisterCubit());
    gh.lazySingleton<_i18.RegisterRemoteDataSource>(
        () => _i18.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i19.RegisterRepository>(
        () => _i20.RegisterRepositoryImpl(gh<_i18.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i21.StartupCubit>(() => _i21.StartupCubit());
    return this;
  }
}

class _$RegisterModule extends _i22.RegisterModule {}
