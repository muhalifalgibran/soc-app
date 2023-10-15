import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, void>> createPost(Post post);
}
