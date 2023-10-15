import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/post/domain/usecases/create_post.dart';
import 'package:soc_app/features/post/domain/usecases/get_tags.dart';

enum PostStatusState {
  initial,
  loading,
  success,
  failed,
}

class PostState extends Equatable {
  final PostStatusState status;
  final Failure? failure;
  final List<String>? usernames;

  const PostState({
    this.status = PostStatusState.initial,
    this.failure,
    this.usernames,
  });

  bool get isLoading => status == PostStatusState.loading;
  bool get isSuccess => status == PostStatusState.success;
  bool get isFailed => status == PostStatusState.failed;

  PostState copyWith({
    PostStatusState? status,
    Failure? failure,
    List<String>? usernames,
  }) =>
      PostState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
        usernames: usernames ?? this.usernames,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
        usernames,
      ];
}

@LazySingleton()
class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  void createPost(Post post) async {
    emit(state.copyWith(status: PostStatusState.loading));
    final result = await getIt<CreatePost>().call(post);
    result.fold(
      (error) {
        emit(state.copyWith(status: PostStatusState.failed, failure: error));
      },
      (success) {
        emit(state.copyWith(status: PostStatusState.success));
      },
    );
  }
}
