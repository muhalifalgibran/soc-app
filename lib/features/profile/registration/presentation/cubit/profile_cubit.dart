import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/logout_user.dart';

enum ProfileStatusState {
  initial,
  loading,
  success,
  failed,
  successLogout,
  loadingLogout,
  successGetProfile,
}

class ProfileState extends Equatable {
  final ProfileStatusState status;
  final Failure? failure;

  const ProfileState({
    this.status = ProfileStatusState.initial,
    this.failure,
  });

  bool get isLoading => status == ProfileStatusState.loading;
  bool get isSuccess => status == ProfileStatusState.success;
  bool get isFailed => status == ProfileStatusState.failed;
  bool get isSuccessLogout => status == ProfileStatusState.successLogout;
  bool get isLoadingLogout => status == ProfileStatusState.loadingLogout;

  ProfileState copyWith({
    ProfileStatusState? status,
    Failure? failure,
  }) =>
      ProfileState(
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
        box.close();
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
  }
}
