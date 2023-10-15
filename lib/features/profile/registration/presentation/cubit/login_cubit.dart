import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/login_user.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/logout_user.dart';

enum LoginStatusState {
  initial,
  loading,
  success,
  failed,
  successLogout,
}

class LoginState extends Equatable {
  final LoginStatusState status;
  final Failure? failure;

  const LoginState({
    this.status = LoginStatusState.initial,
    this.failure,
  });

  bool get isLoading => status == LoginStatusState.loading;
  bool get isSuccess => status == LoginStatusState.success;
  bool get isFailed => status == LoginStatusState.failed;
  bool get isSuccessLogout => status == LoginStatusState.successLogout;

  LoginState copyWith({
    LoginStatusState? status,
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
    emit(state.copyWith(status: LoginStatusState.loading));
    var usecase = getIt<LoginUser>();
    var result = await usecase.call(email, password);

    // use dartz library helps us make the call map is readable and functional
    result.fold(
      (error) => emit(
        state.copyWith(
          status: LoginStatusState.failed,
          failure: error,
        ),
      ),
      (data) async {
        var box = await Hive.openBox('userStatus');
        box.put('isLoggedIn', true);
        box.put('userUid', data);
        box.close();
        emit(
          state.copyWith(
            status: LoginStatusState.success,
          ),
        );
      },
    );
  }
}
