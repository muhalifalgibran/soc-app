import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/app.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/login_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/register_page.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  String email = '';
  String password = '';

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void showErrorMessage(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              data,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isLoading) {
            showAboutDialog(context: context);
          } else if (state.isSuccess) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const App()));
          } else if (state.isFailed) {
            showErrorMessage(
              context,
              state.failure?.message ?? 'something is wrong..',
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const NeuContainer(
                  backgroundColor: Colors.black54,
                  child: Text(
                    'Soc.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: NeuContainer(
                    child: Column(
                      children: [
                        SocForm(
                          label: 'Email',
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        SocForm(
                          label: 'Password',
                          obscure: true,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SocButton(
                  onPressed: () {
                    getIt<LoginCubit>().login(email, password);
                  },
                  label: 'Login',
                ),
                const SizedBox(height: 20),
                SocButton(
                  onPressed: () async {
                    // go to register page, give delay for better ux
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    });
                  },
                  label: 'Register',
                  color: Colors.blue.shade100,
                ),
                const SizedBox(height: 20),
                // SocButton(
                //   onPressed: () {},
                //   width: 290,
                //   prefix: const Icon(Icons.mail_outline_rounded),
                //   label: 'Register with email',
                //   color: Colors.red.shade300,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
