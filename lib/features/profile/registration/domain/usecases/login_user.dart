import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/repositories/login_repository.dart';

@Injectable()
class LoginUser {
  final _repo = getIt<LoginRepository>();

  // use call to directly call the usecase
  Future<Either<Failure, void>> call(String email, String password) =>
      _repo.login(email, password);
}
