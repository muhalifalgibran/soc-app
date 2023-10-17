import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/error/failure.dart';
import 'package:soc_app/core/utils/general_status_state.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/your_page/domain/usecases/get_your_page.dart';

class YourPageState extends Equatable {
  final GeneralStatusState status;
  final List<Post>? posts;
  final Failure? failure;

  const YourPageState({
    this.status = GeneralStatusState.initial,
    this.posts,
    this.failure,
  });

  bool get isLoading => status == GeneralStatusState.loading;
  bool get isSuccess => status == GeneralStatusState.success;
  bool get isFailed => status == GeneralStatusState.failed;

  YourPageState copyWith({
    GeneralStatusState? status,
    List<Post>? posts,
    Failure? failure,
  }) =>
      YourPageState(
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
class YourPageCubit extends Cubit<YourPageState> {
  YourPageCubit() : super(const YourPageState());

  void getYourPage() async {
    emit(state.copyWith(status: GeneralStatusState.loading));
    final api = await getIt<GetYourPage>().call();

    api.fold((error) {
      emit(state.copyWith(status: GeneralStatusState.failed, failure: error));
    }, (data) {
      emit(state.copyWith(status: GeneralStatusState.success, posts: data));
    });
  }
}
