import 'package:dartz/dartz.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

import '../../../../post/domain/entities/post.dart';

abstract class ProfileRepository {
  Future<Either<Failure, SocUser>> getProfile();
  Future<Either<Failure, List<Post>>> getPosts(String userId);
}
