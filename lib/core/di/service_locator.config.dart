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
    as _i16;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i18;
import '../../features/post/domain/repositories/post_repository.dart' as _i17;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/domain/usecases/get_tags.dart' as _i7;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i15;
import '../../features/post/presentation/cubits/tag_cubit.dart' as _i28;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i10;
import '../../features/profile/registration/data/datasource/profile_remote_data_source.dart'
    as _i20;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i24;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i12;
import '../../features/profile/registration/data/repositories/profile_repository_impl.dart'
    as _i22;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i26;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i11;
import '../../features/profile/registration/domain/repositories/profile_repository.dart'
    as _i21;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i25;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/get_posts.dart'
    as _i5;
import '../../features/profile/registration/domain/usecases/get_profile.dart'
    as _i6;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i13;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i14;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i9;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i19;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i23;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i27;
import '../network/graphql_module.dart' as _i8;
import 'register_module.dart' as _i29;

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
    gh.factory<_i5.GetPosts>(() => _i5.GetPosts());
    gh.factory<_i6.GetProfile>(() => _i6.GetProfile());
    gh.factory<_i7.GetUsernames>(() => _i7.GetUsernames());
    gh.singleton<_i8.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i9.LoginCubit>(() => _i9.LoginCubit());
    gh.lazySingleton<_i10.LoginRemoteDataSource>(
        () => _i10.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i11.LoginRepository>(() => _i12.LoginRepositoryImpl());
    gh.factory<_i13.LoginUser>(() => _i13.LoginUser());
    gh.factory<_i14.LogoutUser>(() => _i14.LogoutUser());
    gh.lazySingleton<_i15.PostCubit>(() => _i15.PostCubit());
    gh.lazySingleton<_i16.PostRemoteDataSource>(
        () => _i16.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i17.PostRepository>(() => _i18.PostRepositoryImpl());
    gh.lazySingleton<_i19.ProfileCubit>(() => _i19.ProfileCubit());
    gh.lazySingleton<_i20.ProfileRemoteDataSource>(
        () => _i20.ProfileRemoteDataSourceImpl());
    gh.lazySingleton<_i21.ProfileRepository>(
        () => _i22.ProfileRepositoryImpl());
    gh.lazySingleton<_i23.RegisterCubit>(() => _i23.RegisterCubit());
    gh.lazySingleton<_i24.RegisterRemoteDataSource>(
        () => _i24.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i25.RegisterRepository>(
        () => _i26.RegisterRepositoryImpl(gh<_i24.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i27.StartupCubit>(() => _i27.StartupCubit());
    gh.factory<_i28.TagCubit>(() => _i28.TagCubit());
    return this;
  }
}

class _$RegisterModule extends _i29.RegisterModule {}
