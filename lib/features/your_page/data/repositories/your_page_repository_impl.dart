import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/your_page/data/datasources/your_page_datasource.dart';
import 'package:soc_app/features/your_page/domain/repositories/your_page_repository.dart';

@LazySingleton(as: YourPageRepository)
class YourPageRepositoryImpl implements YourPageRepository {
  final _datasource = getIt<YourPageDataSource>();
  @override
  Future<Either<Failure, List<Post>>> getYourPage() async {
    try {
      final result = await _datasource.getYourPage();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
