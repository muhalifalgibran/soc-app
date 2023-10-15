import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/profile_repository.dart';

@Injectable()
class GetPosts {
  final _repo = getIt<ProfileRepository>();

  Future<Either<Failure, List<Post>>> call(String userId) =>
      _repo.getPosts(userId);
}
