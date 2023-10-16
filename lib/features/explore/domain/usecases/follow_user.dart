import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/domain/repositories/follow_repository.dart';

@Injectable()
class FollowUser {
  final _repo = getIt<FollowRepository>();

  Future<Either<Failure, void>> call(String targetUserId) =>
      _repo.follow(targetUserId);
}
