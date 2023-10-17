import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_posts.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_profile.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';

import '../../utils.dart';

// mock the usecase
class MockGetProfile extends Mock implements GetProfile {}

class MockGetPosts extends Mock implements GetPosts {}

// mock hive too
class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late MockHiveInterface mockHive;
  late MockBox mockBox;

  late GetProfile getProfile;
  late GetPosts getPosts;
  late ProfileCubit cubit;

  // init the hive
  void initHive() {
    var path = Directory.current.path;
    Hive.init('$path/test/unit_test');
  }

  initHive();

  setUpAll(() {
    // setup all instances
    getProfile = MockGetProfile();
    getPosts = MockGetPosts();
    cubit = ProfileCubit();

    mockHive = MockHiveInterface();
    mockBox = MockBox();

    registerTestLazySingleton<GetProfile>(getProfile);
    registerTestLazySingleton<GetPosts>(getPosts);
  });

  SocUser user = const SocUser(
    username: 'username',
    picUrl: 'picUrl',
    id: 'id',
    email: 'email',
    followee: [],
    following: [],
    authUid: '123',
    posts: [],
  );
  group('-get profile: ', () {
    test('should emit failure when error thrown from usecase', () async {
      // arrange
      when(() => getProfile.call()).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'error server')));

      // act
      cubit.getProfile();

      // verify
      verify(() => getProfile.call()).called(1);

      // should emit failed
      emits(
        const ProfileState(
            status: ProfileStatusState.failed,
            failure: ServerFailure(message: 'error server')),
      );
    });

    test('should emit success', () async {
      // arrange
      when(() => getProfile.call()).thenAnswer((_) async => Right(user));

      // act
      cubit.getProfile();

      // verify
      verify(() => getProfile.call()).called(1);

      // should emit failed
      emits(
        ProfileState(
          status: ProfileStatusState.success,
          user: user,
        ),
      );
    });
  });

  group('-get posts', () {
    test('should emit failed when user id is empty', () {
      String userId = '12321';
      // arrange
      when(() => mockHive.openBox('userStatus'))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.get('userUid')).thenAnswer(
        (_) async => '',
      );

      when(() => getPosts.call(userId)).thenAnswer(
        (_) async => const Left(
          ServerFailure(message: 'error server'),
        ),
      );

      // act
      cubit.getPosts();

      // verify that this is never called
      verifyNever(() => getPosts.call(any()));

      // verify emit
      emits(
        const ProfileState(
          status: ProfileStatusState.failed,
          failure: ClientFailure(message: 'Failed to get user id'),
        ),
      );
    });
  });
}
