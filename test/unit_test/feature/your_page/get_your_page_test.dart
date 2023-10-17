import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/your_page/domain/repositories/your_page_repository.dart';
import 'package:soc_app/features/your_page/domain/usecases/get_your_page.dart';

import '../../utils.dart';

class MockYourPageRepository extends Mock implements YourPageRepository {}

void main() {
  late YourPageRepository mockRepo;
  late GetYourPage usecase;

  setUpAll(() {
    mockRepo = MockYourPageRepository();
    registerTestLazySingleton<YourPageRepository>(mockRepo);

    usecase = GetYourPage();
  });

  const posts = [
    Post(
      caption: 'caption',
      postPic: 'postPic',
      userId: 'userId',
      username: 'username',
    ),
    Post(
      caption: 'caption',
      postPic: 'postPic',
      userId: 'userId',
      username: 'username',
    ),
    Post(
      caption: 'caption',
      postPic: 'postPic',
      userId: 'userId',
      username: 'username',
    ),
  ];
  test('Should return List of post', () async {
    // arrange
    when(() => mockRepo.getYourPage())
        .thenAnswer((_) async => const Right(posts));

    // act
    final api = await usecase.call();

    // verify
    verify(() => mockRepo.getYourPage()).called(1);
    expect(api, const Right(posts));
  });

  test('Should return failure when get error from repository', () async {
    // arrange
    when(() => mockRepo.getYourPage())
        .thenAnswer((_) async => const Left(ServerFailure()));

    // act
    final api = await usecase.call();

    // verify
    verify(() => mockRepo.getYourPage()).called(1);
    expect(api, const Left(ServerFailure()));
  });
}
