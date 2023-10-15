import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/data/datasources/post_remote_data_source.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/post/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final _dataSource = getIt<PostRemoteDataSource>();
  @override
  Future<Either<Failure, void>> createPost(Post post) async {
    try {
      final result = await _dataSource.createPost(post);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
