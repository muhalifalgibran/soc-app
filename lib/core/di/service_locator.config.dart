// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/explore/data/datasources/explore_data_source.dart'
    as _i7;
import '../../features/explore/data/repositories/explore_repository_impl.dart'
    as _i9;
import '../../features/explore/domain/repositories/explore_repository.dart'
    as _i8;
import '../../features/explore/domain/usecases/get_users.dart' as _i13;
import '../../features/explore/presentation/cubits/detail_profile_post_cubit.dart'
    as _i5;
import '../../features/explore/presentation/cubits/explore_cubit.dart' as _i6;
import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i22;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i24;
import '../../features/post/domain/repositories/post_repository.dart' as _i23;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/domain/usecases/get_tags.dart' as _i12;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i21;
import '../../features/post/presentation/cubits/tag_cubit.dart' as _i34;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i16;
import '../../features/profile/registration/data/datasource/profile_remote_data_source.dart'
    as _i26;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i30;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i18;
import '../../features/profile/registration/data/repositories/profile_repository_impl.dart'
    as _i28;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i32;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i17;
import '../../features/profile/registration/domain/repositories/profile_repository.dart'
    as _i27;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i31;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/get_posts.dart'
    as _i10;
import '../../features/profile/registration/domain/usecases/get_profile.dart'
    as _i11;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i19;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i20;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i15;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i25;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i29;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i33;
import '../network/graphql_module.dart' as _i14;
import 'register_module.dart' as _i35;

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
    gh.lazySingleton<_i5.DetailProfilePostCubit>(
        () => _i5.DetailProfilePostCubit());
    gh.lazySingleton<_i6.ExploreCubit>(() => _i6.ExploreCubit());
    gh.lazySingleton<_i7.ExploreDataSource>(() => _i7.ExploreDataSourceImpl());
    gh.lazySingleton<_i8.ExploreRepository>(() => _i9.ExploreRepositoryImpl());
    gh.factory<_i10.GetPosts>(() => _i10.GetPosts());
    gh.factory<_i11.GetProfile>(() => _i11.GetProfile());
    gh.factory<_i12.GetUsernames>(() => _i12.GetUsernames());
    gh.factory<_i13.GetUsers>(() => _i13.GetUsers());
    gh.singleton<_i14.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i15.LoginCubit>(() => _i15.LoginCubit());
    gh.lazySingleton<_i16.LoginRemoteDataSource>(
        () => _i16.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i17.LoginRepository>(() => _i18.LoginRepositoryImpl());
    gh.factory<_i19.LoginUser>(() => _i19.LoginUser());
    gh.factory<_i20.LogoutUser>(() => _i20.LogoutUser());
    gh.lazySingleton<_i21.PostCubit>(() => _i21.PostCubit());
    gh.lazySingleton<_i22.PostRemoteDataSource>(
        () => _i22.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i23.PostRepository>(() => _i24.PostRepositoryImpl());
    gh.lazySingleton<_i25.ProfileCubit>(() => _i25.ProfileCubit());
    gh.lazySingleton<_i26.ProfileRemoteDataSource>(
        () => _i26.ProfileRemoteDataSourceImpl());
    gh.lazySingleton<_i27.ProfileRepository>(
        () => _i28.ProfileRepositoryImpl());
    gh.lazySingleton<_i29.RegisterCubit>(() => _i29.RegisterCubit());
    gh.lazySingleton<_i30.RegisterRemoteDataSource>(
        () => _i30.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i31.RegisterRepository>(
        () => _i32.RegisterRepositoryImpl(gh<_i30.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i33.StartupCubit>(() => _i33.StartupCubit());
    gh.factory<_i34.TagCubit>(() => _i34.TagCubit());
    return this;
  }
}

class _$RegisterModule extends _i35.RegisterModule {}
