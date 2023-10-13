import 'package:flutter/material.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_form.dart';

import '../../../../widgets/soc_button.dart';

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
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
              onPressed: () {},
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
