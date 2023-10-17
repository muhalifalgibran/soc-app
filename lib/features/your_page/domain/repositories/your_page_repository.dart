import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

abstract class YourPageRepository {
  // interface to get the data
  Future<Either<Failure, List<Post>>> getYourPage();
}
