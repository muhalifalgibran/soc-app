import 'package:soc_app/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required String? id,
    required String? caption,
    required List<String>? tags,
    required String? postPic,
    required String? userId,
  }) : super(
          id: id ?? '',
          caption: caption ?? '',
          tags: tags ?? [],
          postPic: postPic ?? '',
          userId: userId ?? '',
        );
}
