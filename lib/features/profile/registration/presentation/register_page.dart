import 'package:flutter/material.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const NeuContainer(
                backgroundColor: Colors.black54,
                child: Text(
                  'Register your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                      label: 'Username',
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
              onPressed: () {},
              label: 'Register',
              color: Colors.blue.shade100,
            ),
          ],
        ),
      ),
    );
  }
}
