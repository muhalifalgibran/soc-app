import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/domain/repositories/explore_repository.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

@Injectable()
class GetUsers {
  final _repo = getIt<ExploreRepository>();

  Future<Either<Failure, List<SocUser>>> call() => _repo.getUsers();
}
