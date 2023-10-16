import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/explore/domain/usecases/follow_user.dart';
import 'package:soc_app/features/explore/domain/usecases/unfollow_user.dart';
import 'package:soc_app/features/explore/presentation/cubits/detail_profile_post_cubit.dart';

enum FollowUnfollowStatusState {
  initial,
  loading,
  success,
  failed,
  successFollow,
  failedFollow,
  successUnfollow,
  failedUnfollow,
}

class FollowUnfollowState extends Equatable {
  final DetailProfileStatusState status;
  final Failure? failure;

  const FollowUnfollowState({
    this.status = DetailProfileStatusState.initial,
    this.failure,
  });

  bool get isSuccess => status == DetailProfileStatusState.success;
  bool get isLoading => status == DetailProfileStatusState.loading;
  bool get isSuccessFollow => status == DetailProfileStatusState.successFollow;
  bool get isSuccessUnfollow =>
      status == DetailProfileStatusState.successUnfollow;

  FollowUnfollowState copyWith({
    DetailProfileStatusState? status,
    Failure? failure,
  }) =>
      FollowUnfollowState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
      ];
}

@LazySingleton()
class FollowUnfollowCubit extends Cubit<FollowUnfollowState> {
  FollowUnfollowCubit() : super(const FollowUnfollowState());

  void follow(String targetUserId) async {
    emit(state.copyWith(status: DetailProfileStatusState.loading));
    final result = await getIt<FollowUser>().call(targetUserId);

    result.fold((error) {
      emit(state.copyWith(
        status: DetailProfileStatusState.failedFollow,
        failure: error,
      ));
    }, (success) async {
      emit(state.copyWith(
        status: DetailProfileStatusState.successFollow,
      ));
    });
  }

  void unfollow(String targetUserId) async {
    emit(state.copyWith(status: DetailProfileStatusState.loading));
    final result = await getIt<UnfollowUser>().call(targetUserId);

    result.fold((error) {
      emit(state.copyWith(
        status: DetailProfileStatusState.failedUnfollow,
        failure: error,
      ));
    }, (success) async {
      emit(state.copyWith(
        status: DetailProfileStatusState.successUnfollow,
      ));
    });
  }
}
