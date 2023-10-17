import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:soc_app/core/network/graphql_module.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soc_app/features/post/data/models/post_model.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/data/datasource/profile_remote_data_source.dart';
import 'package:soc_app/features/profile/registration/data/model/user_model.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

import '../../utils.dart';

// using mocktail to mock the classes
class MockGraphQLModule extends Mock implements GraphQLModule {}

// mock hive too
class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late final GraphQLModule module;
  late ProfileRemoteDataSource dataSource;
  late MockHiveInterface mockHive;
  late MockBox mockBox;

  void initHive() {
    var path = Directory.current.path;
    Hive.init('$path/test/unit_test');
  }

  initHive();

  setUpAll(() {
    // set up the instances
    module = MockGraphQLModule();
    mockHive = MockHiveInterface();
    mockBox = MockBox();

    // register our get it
    registerTestLazySingleton<GraphQLModule>(module);

    // register the hive
    registerTestFactory<HiveInterface>(mockHive);
    registerTestFactory<Box<dynamic>>(mockBox);
    dataSource = ProfileRemoteDataSourceImpl();
  });

  var userDataMap = {
    'users': [
      {
        'email': 'emailDummy',
        'followee': null,
        'following': null,
        'pic_url': 'pic_urlDummy',
        'id': 'idDummy',
        'post': null,
        'username': 'usernameDummy'
      }
    ],
  };

  Map<String, dynamic> userPost = {
    'posts': [
      {
        'post_pic': 'post_pic_dummy',
        'tags': [],
        'id': 'id_dummy',
        'caption': 'caption_dummy',
        'user_id': 'user_id_dummy',
      },
      {
        'post_pic': 'post_pic_dummy',
        'tags': [],
        'id': 'id_dummy',
        'caption': 'caption_dummy',
        'user_id': 'user_id_dummy',
      },
      {
        'post_pic': 'post_pic_dummy',
        'tags': [],
        'id': 'id_dummy',
        'caption': 'caption_dummy',
        'user_id': 'user_id_dummy',
      }
    ]
  };

  test('should return user profile', () async {
    // arrange
    when(() => module.queryMethod(any())).thenAnswer((_) async => userDataMap);

    when(() => mockHive.openBox('userStatus')).thenAnswer((_) async => mockBox);
    when(() => mockBox.get('userUid')).thenAnswer((_) async => '12321');

    // act
    final api = await dataSource.getUserProfile();

    // verify
    // the valid return
    expect(api, isA<SocUser>());
    expect(api, UserModel.fromJson(userDataMap['users']![0]));
    verify(
      () => module.queryMethod(any()),
    ).called(1);
  });

  test('should return user\'s post', () async {
    // arrange
    when(() => module.queryMethod(any())).thenAnswer((_) async => userPost);

    // act
    final api = await dataSource.getPosts('123');

    // verify
    // the valid return
    expect(api, isA<List<Post>>());
    expect(
      api,
      userPost['posts'].map<Post>((e) => PostModel.fromJson(e)).toList(),
    );
    verify(
      () => module.queryMethod(any()),
    ).called(1);
  });
}
