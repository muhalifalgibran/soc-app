import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/domain/usecases/follow_user.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_posts.dart';

enum DetailProfileStatusState {
  initial,
  loading,
  success,
  failed,
  successFollow,
  failedFollow,
  successUnfollow,
  failedUnfollow,
}

class DetailProfilePostState extends Equatable {
  final DetailProfileStatusState status;
  final List<Post>? posts;
  final Failure? failure;

  const DetailProfilePostState({
    this.status = DetailProfileStatusState.initial,
    this.posts,
    this.failure,
  });

  bool get isSuccess => status == DetailProfileStatusState.success;
  bool get isLoading => status == DetailProfileStatusState.loading;
  bool get isSuccessFollow => status == DetailProfileStatusState.successFollow;
  bool get isSuccessUnfollow =>
      status == DetailProfileStatusState.successUnfollow;

  DetailProfilePostState copyWith({
    DetailProfileStatusState? status,
    List<Post>? posts,
    Failure? failure,
  }) =>
      DetailProfilePostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [
        status,
        posts,
        failure,
      ];
}

@LazySingleton()
class DetailProfilePostCubit extends Cubit<DetailProfilePostState> {
  DetailProfilePostCubit() : super(const DetailProfilePostState());

  void getPosts(String userId) async {
    emit(state.copyWith(status: DetailProfileStatusState.loading));

    if (userId != '') {
      final getUser = await getIt<GetPosts>().call(userId);

      getUser.fold(
        (error) => emit(
          state.copyWith(
            status: DetailProfileStatusState.failed,
            failure: error,
          ),
        ),
        (data) {
          emit(
            state.copyWith(
              status: DetailProfileStatusState.success,
              posts: data,
            ),
          );
        },
      );
    } else {
      emit(state.copyWith(
        status: DetailProfileStatusState.failed,
        failure: const ClientFailure(message: 'Failed to get user id'),
      ));
    }
  }

  // void follow(String targetUserId) async {
  //   emit(state.copyWith(status: DetailProfileStatusState.loading));
  //   final result = await getIt<FollowUser>().call(targetUserId);

  //   result.fold((error) {
  //     state.copyWith(
  //       status: DetailProfileStatusState.failedUnfollow,
  //       failure: error,
  //     );
  //   }, (success) async {
  //     state.copyWith(
  //       status: DetailProfileStatusState.successFollow,
  //     );
  //   });
  // }
}
