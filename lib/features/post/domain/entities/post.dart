import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? id;
  final String caption;
  final List<String>? tags;
  final String postPic;
  final String userId;

  const Post({
    this.id,
    required this.caption,
    this.tags,
    required this.postPic,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        caption,
        tags,
        postPic,
        userId,
      ];
}
