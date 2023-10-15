import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/profile_repository.dart';

@Injectable()
class GetProfile {
  final _repo = getIt<ProfileRepository>();

  Future<Either<Failure, SocUser>> call() => _repo.getProfile();
}
