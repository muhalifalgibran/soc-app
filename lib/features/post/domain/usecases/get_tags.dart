import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/post/domain/repositories/post_repository.dart';

@Injectable()
class GetUsernames {
  final _repo = getIt<PostRepository>();

  Future<Either<Failure, List<String>>> call(String username) =>
      _repo.getTags(username);
}
