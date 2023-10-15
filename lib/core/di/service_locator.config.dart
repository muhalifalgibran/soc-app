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
    as _i14;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i16;
import '../../features/post/domain/repositories/post_repository.dart' as _i15;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i13;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i8;
import '../../features/profile/registration/data/datasource/profile_remote_data_source.dart'
    as _i18;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i22;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i10;
import '../../features/profile/registration/data/repositories/profile_repository_impl.dart'
    as _i20;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i24;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i9;
import '../../features/profile/registration/domain/repositories/profile_repository.dart'
    as _i19;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i23;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/get_profile.dart'
    as _i5;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i11;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i12;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i7;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i17;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i21;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i25;
import '../network/graphql_module.dart' as _i6;
import 'register_module.dart' as _i26;

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
    gh.factory<_i5.GetProfile>(() => _i5.GetProfile());
    gh.singleton<_i6.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i7.LoginCubit>(() => _i7.LoginCubit());
    gh.lazySingleton<_i8.LoginRemoteDataSource>(
        () => _i8.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i9.LoginRepository>(() => _i10.LoginRepositoryImpl());
    gh.factory<_i11.LoginUser>(() => _i11.LoginUser());
    gh.factory<_i12.LogoutUser>(() => _i12.LogoutUser());
    gh.lazySingleton<_i13.PostCubit>(() => _i13.PostCubit());
    gh.lazySingleton<_i14.PostRemoteDataSource>(
        () => _i14.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i15.PostRepository>(() => _i16.PostRepositoryImpl());
    gh.lazySingleton<_i17.ProfileCubit>(() => _i17.ProfileCubit());
    gh.lazySingleton<_i18.ProfileRemoteDataSource>(
        () => _i18.ProfileRemoteDataSourceImpl());
    gh.lazySingleton<_i19.ProfileRepository>(
        () => _i20.ProfileRepositoryImpl());
    gh.lazySingleton<_i21.RegisterCubit>(() => _i21.RegisterCubit());
    gh.lazySingleton<_i22.RegisterRemoteDataSource>(
        () => _i22.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i23.RegisterRepository>(
        () => _i24.RegisterRepositoryImpl(gh<_i22.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i25.StartupCubit>(() => _i25.StartupCubit());
    return this;
  }
}

class _$RegisterModule extends _i26.RegisterModule {}
