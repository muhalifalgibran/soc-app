import 'package:flutter_test/flutter_test.dart';
import 'package:soc_app/features/post/data/models/post_model.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

main() {
  // initiate model
  PostModel model = PostModel(
    id: 'id',
    caption: 'caption',
    tags: const ['tags'],
    postPic: 'postPic',
    userId: 'userId',
    username: 'username',
  );
  // initiate json
  Map<String, dynamic> json = {
    'id': 'id',
    'caption': 'caption',
    'tags': ['tags'],
    'post_pic': 'postPic',
    'user_id': 'userId',
    'username': 'username',
  };

  test('from json test', () {
    expect(model, PostModel.fromJson(json));
  });

  test('should inherite the post', () {
    expect(model, isA<Post>());
  });
}
