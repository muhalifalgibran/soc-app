import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_posts.dart';

import '../../../../core/utils/general_status_state.dart';

class DetailProfilePostState extends Equatable {
  final GeneralStatusState status;
  final List<Post>? posts;
  final Failure? failure;

  const DetailProfilePostState({
    this.status = GeneralStatusState.initial,
    this.posts,
    this.failure,
  });

  bool get isSuccess => status == GeneralStatusState.success;

  DetailProfilePostState copyWith({
    GeneralStatusState? status,
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
    emit(state.copyWith(status: GeneralStatusState.loading));
    // box.close();
    // get posts by userid
    if (userId != '') {
      final getUser = await getIt<GetPosts>().call(userId);

      getUser.fold(
        (error) => emit(
          state.copyWith(
            status: GeneralStatusState.failed,
            failure: error,
          ),
        ),
        (data) {
          emit(
            state.copyWith(
              status: GeneralStatusState.success,
              posts: data,
            ),
          );
        },
      );
    } else {
      emit(state.copyWith(
        status: GeneralStatusState.failed,
        failure: const ClientFailure(message: 'Failed to get user id'),
      ));
    }
  }
}
