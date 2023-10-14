import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupState extends Equatable {
  const StartupState({
    this.status = GeneralStatusState.initial,
    this.userData,
    this.failure,
  });

  final GeneralStatusState status;
  final UserData? userData;
  final Failure? failure;

  bool get isSuccess => status == GeneralStatusState.success;

  StartupState copyWith({
    GeneralStatusState? status,
    UserData? userData,
    Failure? failure,
  }) =>
      StartupState(
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
class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(const StartupState());

  Future getLoginStatus() async {
    emit(state.copyWith(status: GeneralStatusState.loading));
    var box = await Hive.openBox('userStatus');

    if (box.get('isLoggedIn') == true) {
      emit(state.copyWith(status: GeneralStatusState.success));
    } else {
      emit(state.copyWith(status: GeneralStatusState.failed));
    }

    await Hive.close();
  }
}
