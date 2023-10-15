import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:soc_app/features/post/domain/usecases/get_tags.dart';

import '../../../../core/error/failure.dart';

class TagState extends Equatable {
  final GeneralStatusState status;
  final Failure? failure;
  final List<String>? usernames;

  const TagState({
    this.status = GeneralStatusState.initial,
    this.failure,
    this.usernames,
  });

  bool get isLoading => status == GeneralStatusState.loading;
  bool get isSuccess => status == GeneralStatusState.success;
  bool get isFailed => status == GeneralStatusState.failed;

  TagState copyWith({
    GeneralStatusState? status,
    Failure? failure,
    List<String>? usernames,
  }) =>
      TagState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
        usernames: usernames ?? this.usernames,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
        usernames,
      ];
}

@Injectable()
class TagCubit extends Cubit<TagState> {
  TagCubit() : super(const TagState());

  void getTags(String username) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await getIt<GetUsernames>().call(username);
    result.fold(
      (error) {
        emit(state.copyWith(status: GeneralStatusState.failed, failure: error));
      },
      (success) {
        emit(
          state.copyWith(
            status: GeneralStatusState.success,
            usernames: success,
          ),
        );
      },
    );
  }
}
