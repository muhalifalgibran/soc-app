import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/your_page/domain/repositories/your_page_repository.dart';

@Injectable()
class GetYourPage {
  final _repo = getIt<YourPageRepository>();

  Future<Either<Failure, List<Post>>> call() => _repo.getYourPage();
}
