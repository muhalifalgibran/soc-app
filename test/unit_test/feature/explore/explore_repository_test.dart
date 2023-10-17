import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/data/datasources/explore_data_source.dart';
import 'package:soc_app/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:soc_app/features/explore/domain/repositories/explore_repository.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

import '../../utils.dart';

class MockExploreDataSource extends Mock implements ExploreDataSource {}

void main() {
  late ExploreDataSource mockDataSource;
  late ExploreRepository repo;

  setUpAll(() {
    mockDataSource = MockExploreDataSource();
    registerTestLazySingleton<ExploreDataSource>(mockDataSource);
    repo = ExploreRepositoryImpl();
  });

  test('should return failure when datasource thrown an error', () async {
    // arrange
    when(() => mockDataSource.getUsers()).thenThrow(Exception('Error Server'));

    // act
    final api = await repo.getUsers();

    //verify
    verify(() => mockDataSource.getUsers()).called(1);
    expect(api,
        equals(const Left(ServerFailure(message: 'Exception: Error Server'))));
  });

  test('should return data when call datasource is success', () async {
    var a = [
      const SocUser(
        username: 'username',
        picUrl: 'picUrl',
        id: 'id',
        email: 'email',
        followee: [],
        following: [],
        authUid: 'authUid',
        posts: [],
      ),
    ];
    // arrange
    when(() => mockDataSource.getUsers()).thenAnswer((_) async => a);

    // act
    final api = await repo.getUsers();

    //verify
    verify(() => mockDataSource.getUsers()).called(1);
    expect(api, equals(Right(a)));
  });
}
