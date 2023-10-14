import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/register_cubit.dart';
import 'package:soc_app/features/startup/presentation/cubit/startup_cubit.dart';

class Injection {
  Injection._privateConstructor();

  static final Injection _instance = Injection._privateConstructor();

  static Injection get instance => _instance;

  List<BlocProvider> initBloc() => [
        BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider<StartupCubit>(
          create: (context) => getIt<StartupCubit>(),
        ),
      ];
}
