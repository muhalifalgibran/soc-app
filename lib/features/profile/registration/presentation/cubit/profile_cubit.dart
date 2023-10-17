import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_posts.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/get_profile.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/logout_user.dart';

enum ProfileStatusState {
  initial,
  loading,
  success,
  failed,
  successLogout,
  loadingLogout,
  successGetProfile,
  successGetPosts,
}

class ProfileState extends Equatable {
  final ProfileStatusState status;
  final Failure? failure;
  final SocUser? user;
  final List<Post>? posts;

  const ProfileState({
    this.status = ProfileStatusState.initial,
    this.failure,
    this.user,
    this.posts,
  });

  bool get isLoading => status == ProfileStatusState.loading;
  bool get isSuccess => status == ProfileStatusState.success;
  bool get isFailed => status == ProfileStatusState.failed;
  bool get isSuccessLogout => status == ProfileStatusState.successLogout;
  bool get isLoadingLogout => status == ProfileStatusState.loadingLogout;
  bool get isSuccessGetProfile =>
      status == ProfileStatusState.successGetProfile;
  bool get isSuccessGetPosts => status == ProfileStatusState.successGetPosts;

  ProfileState copyWith({
    ProfileStatusState? status,
    SocUser? user,
    Failure? failure,
    List<Post>? posts,
  }) =>
      ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        failure: failure ?? this.failure,
        posts: posts ?? this.posts,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
        user,
        posts,
      ];
}

@LazySingleton()
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void logout() async {
    emit(state.copyWith(status: ProfileStatusState.loading));
    var usecase = getIt<LogoutUser>();
    var result = await usecase.call();

    // use dartz library helps us make the call map is readable and functional
    result.fold(
      (error) => emit(
        state.copyWith(
          status: ProfileStatusState.failed,
          failure: error,
        ),
      ),
      (data) async {
        var box = await Hive.openBox('userStatus');
        box.put('isLoggedIn', false);
        // box.close();
        emit(
          state.copyWith(
            status: ProfileStatusState.successLogout,
          ),
        );
      },
    );
  }

  void getProfile() async {
    emit(state.copyWith(status: ProfileStatusState.loading));
    final getUser = await getIt<GetProfile>().call();

    getUser.fold(
      (error) => emit(
        state.copyWith(
          status: ProfileStatusState.failed,
          failure: error,
        ),
      ),
      (data) async {
        var box = await Hive.openBox('userStatus');
        box.put('username', data.username);

        emit(
          state.copyWith(
            status: ProfileStatusState.successGetProfile,
            user: data,
          ),
        );
      },
    );
  }

  void getPosts() async {
    emit(state.copyWith(status: ProfileStatusState.loading));
    String? userId;
    var box = await Hive.openBox('userStatus');
    userId = box.get('userUid');
    // box.close();
    // get posts by userid
    if (userId != '') {
      final getPosts = await getIt<GetPosts>().call(userId!);

      // give throttle because when it goes so fast
      // sometimes the emit is slips by
      await Future.delayed(const Duration(milliseconds: 750));

      getPosts.fold(
        (error) => emit(
          state.copyWith(
            status: ProfileStatusState.failed,
            failure: error,
          ),
        ),
        (data) {
          emit(
            state.copyWith(
              status: ProfileStatusState.successGetPosts,
              posts: data,
            ),
          );
        },
      );
    } else {
      emit(state.copyWith(
        status: ProfileStatusState.failed,
        failure: const ClientFailure(message: 'Failed to get user id'),
      ));
    }
  }
}
