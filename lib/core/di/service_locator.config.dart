// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql_flutter/graphql_flutter.dart' as _i19;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/explore/data/datasources/explore_data_source.dart'
    as _i7;
import '../../features/explore/data/repositories/explore_repository_impl.dart'
    as _i9;
import '../../features/explore/data/repositories/follow_repository_impl.dart'
    as _i11;
import '../../features/explore/domain/repositories/explore_repository.dart'
    as _i8;
import '../../features/explore/domain/repositories/follow_repository.dart'
    as _i10;
import '../../features/explore/domain/usecases/follow_user.dart' as _i13;
import '../../features/explore/domain/usecases/get_users.dart' as _i17;
import '../../features/explore/domain/usecases/unfollow_user.dart' as _i41;
import '../../features/explore/presentation/cubits/detail_profile_post_cubit.dart'
    as _i5;
import '../../features/explore/presentation/cubits/explore_cubit.dart' as _i6;
import '../../features/explore/presentation/cubits/follow_unfollow_cubit.dart'
    as _i12;
import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i28;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i30;
import '../../features/post/domain/repositories/post_repository.dart' as _i29;
import '../../features/post/domain/usecases/create_post.dart' as _i3;
import '../../features/post/domain/usecases/get_tags.dart' as _i16;
import '../../features/post/presentation/cubits/post_cubit.dart' as _i27;
import '../../features/post/presentation/cubits/tag_cubit.dart' as _i40;
import '../../features/profile/registration/data/datasource/login_remote_datasource.dart'
    as _i22;
import '../../features/profile/registration/data/datasource/profile_remote_data_source.dart'
    as _i32;
import '../../features/profile/registration/data/datasource/register_remote_datasource.dart'
    as _i36;
import '../../features/profile/registration/data/repositories/login_repository_impl.dart'
    as _i24;
import '../../features/profile/registration/data/repositories/profile_repository_impl.dart'
    as _i34;
import '../../features/profile/registration/data/repositories/register_repository_impl.dart'
    as _i38;
import '../../features/profile/registration/domain/repositories/login_repository.dart'
    as _i23;
import '../../features/profile/registration/domain/repositories/profile_repository.dart'
    as _i33;
import '../../features/profile/registration/domain/repositories/register_repository.dart'
    as _i37;
import '../../features/profile/registration/domain/usecases/create_user.dart'
    as _i4;
import '../../features/profile/registration/domain/usecases/get_posts.dart'
    as _i14;
import '../../features/profile/registration/domain/usecases/get_profile.dart'
    as _i15;
import '../../features/profile/registration/domain/usecases/login_user.dart'
    as _i25;
import '../../features/profile/registration/domain/usecases/logout_user.dart'
    as _i26;
import '../../features/profile/registration/presentation/cubit/login_cubit.dart'
    as _i21;
import '../../features/profile/registration/presentation/cubit/profile_cubit.dart'
    as _i31;
import '../../features/profile/registration/presentation/cubit/register_cubit.dart'
    as _i35;
import '../../features/startup/presentation/cubit/startup_cubit.dart' as _i39;
import '../../features/your_page/data/datasources/your_page_datasource.dart'
    as _i43;
import '../../features/your_page/data/repositories/your_page_repository_impl.dart'
    as _i45;
import '../../features/your_page/domain/repositories/your_page_repository.dart'
    as _i44;
import '../../features/your_page/domain/usecases/get_your_page.dart' as _i18;
import '../../features/your_page/presentation/cubits/your_page_cubit.dart'
    as _i42;
import '../network/graphql_module.dart' as _i20;
import 'register_module.dart' as _i46;

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
    gh.lazySingleton<_i10.FollowRepository>(() => _i11.FollowRepositoryImpl());
    gh.lazySingleton<_i12.FollowUnfollowCubit>(
        () => _i12.FollowUnfollowCubit());
    gh.factory<_i13.FollowUser>(() => _i13.FollowUser());
    gh.factory<_i14.GetPosts>(() => _i14.GetPosts());
    gh.factory<_i15.GetProfile>(() => _i15.GetProfile());
    gh.factory<_i16.GetUsernames>(() => _i16.GetUsernames());
    gh.factory<_i17.GetUsers>(() => _i17.GetUsers());
    gh.factory<_i18.GetYourPage>(() => _i18.GetYourPage());
    gh.singleton<_i19.GraphQLClient>(registerModule.graphQLClient);
    gh.singleton<_i20.GraphQLModule>(registerModule.graphQLModule);
    gh.lazySingleton<_i21.LoginCubit>(() => _i21.LoginCubit());
    gh.lazySingleton<_i22.LoginRemoteDataSource>(
        () => _i22.LoginRemoteDataSourceImpl());
    gh.lazySingleton<_i23.LoginRepository>(() => _i24.LoginRepositoryImpl());
    gh.factory<_i25.LoginUser>(() => _i25.LoginUser());
    gh.factory<_i26.LogoutUser>(() => _i26.LogoutUser());
    gh.lazySingleton<_i27.PostCubit>(() => _i27.PostCubit());
    gh.lazySingleton<_i28.PostRemoteDataSource>(
        () => _i28.PostRemoteDataSourceImpl());
    gh.lazySingleton<_i29.PostRepository>(() => _i30.PostRepositoryImpl());
    gh.lazySingleton<_i31.ProfileCubit>(() => _i31.ProfileCubit());
    gh.factory<_i32.ProfileRemoteDataSource>(
        () => _i32.ProfileRemoteDataSourceImpl());
    gh.lazySingleton<_i33.ProfileRepository>(
        () => _i34.ProfileRepositoryImpl());
    gh.lazySingleton<_i35.RegisterCubit>(() => _i35.RegisterCubit());
    gh.lazySingleton<_i36.RegisterRemoteDataSource>(
        () => _i36.RegisterRemoteDataSourceImpl());
    gh.lazySingleton<_i37.RegisterRepository>(
        () => _i38.RegisterRepositoryImpl(gh<_i36.RegisterRemoteDataSource>()));
    gh.lazySingleton<_i39.StartupCubit>(() => _i39.StartupCubit());
    gh.factory<_i40.TagCubit>(() => _i40.TagCubit());
    gh.factory<_i41.UnfollowUser>(() => _i41.UnfollowUser());
    gh.lazySingleton<_i42.YourPageCubit>(() => _i42.YourPageCubit());
    gh.lazySingleton<_i43.YourPageDataSource>(
        () => _i43.YourPageDataSourceImpl());
    gh.lazySingleton<_i44.YourPageRepository>(
        () => _i45.YourPageRepositoryImpl());
    return this;
  }
}

class _$RegisterModule extends _i46.RegisterModule {}
