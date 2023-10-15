import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/login_user.dart';

class LoginState extends Equatable {
  final GeneralStatusState status;
  final Failure? failure;

  const LoginState({
    this.status = GeneralStatusState.initial,
    this.failure,
  });

  bool get isLoading => status == GeneralStatusState.loading;
  bool get isSuccess => status == GeneralStatusState.success;
  bool get isFailed => status == GeneralStatusState.failed;

  LoginState copyWith({
    GeneralStatusState? status,
    Failure? failure,
  }) =>
      LoginState(
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
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login(String email, String password) async {
    emit(state.copyWith(status: GeneralStatusState.loading));
    var usecase = getIt<LoginUser>();
    var result = await usecase.call(email, password);

    // use dartz library helps us make the call map is readable and functional
    result.fold(
      (error) => emit(
        state.copyWith(
          status: GeneralStatusState.failed,
          failure: error,
        ),
      ),
      (data) async {
        var box = await Hive.openBox('userStatus');
        box.put('isLoggedIn', true);
        box.close();
        emit(
          state.copyWith(
            status: GeneralStatusState.success,
          ),
        );
      },
    );
  }
}
