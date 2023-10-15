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

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        caption: json['caption'],
        tags: json['tags'].map<String>((e) => e.toString()).toList() ?? [],
        postPic: json['post_pic'],
        userId: json['user_id'],
      );
}
