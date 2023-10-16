import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:soc_app/features/explore/domain/usecases/get_users.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

class ExploreState extends Equatable {
  final GeneralStatusState status;
  final List<SocUser>? users;
  final Failure? failure;

  const ExploreState({
    this.status = GeneralStatusState.initial,
    this.users,
    this.failure,
  });

  bool get isSuccess => status == GeneralStatusState.success;

  ExploreState copyWith({
    GeneralStatusState? status,
    List<SocUser>? users,
    Failure? failure,
  }) =>
      ExploreState(
        status: status ?? this.status,
        users: users ?? this.users,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [
        status,
        users,
        failure,
      ];
}

@LazySingleton()
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(const ExploreState());

  void getUsers() async {
    emit(state.copyWith(status: GeneralStatusState.loading));

    final result = await getIt<GetUsers>().call();
    // give throttle because when it goes so fast
    // sometimes the emit is slips by
    await Future.delayed(const Duration(milliseconds: 750));
    result.fold(
      (error) => emit(
        state.copyWith(status: GeneralStatusState.failed, failure: error),
      ),
      (data) => emit(
        state.copyWith(status: GeneralStatusState.success, users: data),
      ),
    );
  }
}
