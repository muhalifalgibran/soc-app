import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/domain/usecases/create_user.dart';

class RegisterState extends Equatable {
  final GeneralStatusState status;
  final SocUser? userData;
  final Failure? failure;

  const RegisterState({
    this.status = GeneralStatusState.initial,
    this.userData,
    this.failure,
  });

  RegisterState copyWith({
    GeneralStatusState? status,
    SocUser? userData,
    Failure? failure,
  }) =>
      RegisterState(
        status: status ?? this.status,
        userData: userData ?? this.userData,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [
        status,
        userData,
        failure,
      ];
}

@LazySingleton()
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final usecase = getIt<CreateUser>();

  Future createUser(UserData userData) async {
    emit(state.copyWith(status: GeneralStatusState.loading));

    // get the data by calling the usecase
    final result = await usecase.call(userData);

    // use dartz library helps us make the call map is readable and functional
    result.fold(
      (error) => emit(
        state.copyWith(status: GeneralStatusState.failed),
      ),
      (data) => emit(
        state.copyWith(status: GeneralStatusState.success, userData: data),
      ),
    );
  }
}
