import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/register_repository.dart';

@Injectable()
class CreateUser {
  final _repo = getIt<RegisterRepository>();

  // use call to directly call the usecase
  Future<Either<Failure, SocUser>> call(UserData data) =>
      _repo.createUser(data);
}
