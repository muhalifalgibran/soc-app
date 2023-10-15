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
    as _i15;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i17;
import '../../features/post/domain/repositories/post_repository.dart' as _i16;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/domain/usecases/get_tags.dart' as _i6;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i14;
import '../../features/post/presentation/cubits/tag_cubit.dart' as _i27;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i9;
import '../../features/profile/registration/data/datasource/profile_remote_data_source.dart'
    as _i19;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i23;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i11;
import '../../features/profile/registration/data/repositories/profile_repository_impl.dart'
    as _i21;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i25;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i10;
import '../../features/profile/registration/domain/repositories/profile_repository.dart'
    as _i20;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i24;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/get_profile.dart'
    as _i5;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i12;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i13;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i8;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i18;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i22;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i26;
import '../network/graphql_module.dart' as _i7;
import 'register_module.dart' as _i28;

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
    gh.factory<_i6.GetUsernames>(() => _i6.GetUsernames());
    gh.singleton<_i7.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i8.LoginCubit>(() => _i8.LoginCubit());
    gh.lazySingleton<_i9.LoginRemoteDataSource>(
        () => _i9.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i10.LoginRepository>(() => _i11.LoginRepositoryImpl());
    gh.factory<_i12.LoginUser>(() => _i12.LoginUser());
    gh.factory<_i13.LogoutUser>(() => _i13.LogoutUser());
    gh.lazySingleton<_i14.PostCubit>(() => _i14.PostCubit());
    gh.lazySingleton<_i15.PostRemoteDataSource>(
        () => _i15.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i16.PostRepository>(() => _i17.PostRepositoryImpl());
    gh.lazySingleton<_i18.ProfileCubit>(() => _i18.ProfileCubit());
    gh.lazySingleton<_i19.ProfileRemoteDataSource>(
        () => _i19.ProfileRemoteDataSourceImpl());
    gh.lazySingleton<_i20.ProfileRepository>(
        () => _i21.ProfileRepositoryImpl());
    gh.lazySingleton<_i22.RegisterCubit>(() => _i22.RegisterCubit());
    gh.lazySingleton<_i23.RegisterRemoteDataSource>(
        () => _i23.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i24.RegisterRepository>(
        () => _i25.RegisterRepositoryImpl(gh<_i23.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i26.StartupCubit>(() => _i26.StartupCubit());
    gh.factory<_i27.TagCubit>(() => _i27.TagCubit());
    return this;
  }
}

class _$RegisterModule extends _i28.RegisterModule {}
