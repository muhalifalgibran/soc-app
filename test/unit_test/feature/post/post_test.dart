import 'package:flutter_test/flutter_test.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

void main() {
  // initiate model
  Post entity = const Post(
    id: 'id',
    caption: 'caption',
    tags: ['tags'],
    postPic: 'postPic',
    userId: 'userId',
    username: 'username',
  );
  test('should perform valid props', () {
    const props = [
      'id',
      'caption',
      ['tags'],
      'postPic',
      'userId',
      'username',
    ];
    expect(entity.props, equals(props));
  });
}
