import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/app.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/login_page.dart';
import 'package:soc_app/features/startup/presentation/cubit/startup_cubit.dart';
import 'package:soc_app/widgets/neu_container.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    super.initState();
    getIt<StartupCubit>().getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) async {
        if (state.isSuccess) {
          await Future.delayed(const Duration(milliseconds: 750), () {
            // push replacement, since we want to remove the
            // splash screen page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const App()),
            );
          });
        } else {
          await Future.delayed(const Duration(milliseconds: 750), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: NeuContainer(
            child: Text(
              'Soc.',
              style: TextStyle(fontSize: 36),
            ),
          ),
        ),
      ),
    );
  }
}
