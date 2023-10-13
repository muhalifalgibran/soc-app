import 'package:flutter/material.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/register_page.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    SocForm(
                      label: 'Password',
                      obscure: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SocButton(
              onPressed: () {
                print('object1');
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
    );
  }
}
