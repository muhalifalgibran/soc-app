import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soc_app/app.dart';
import 'package:soc_app/features/your_page/presentation/pages/your_page.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const App(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const NeuContainer(
      //         backgroundColor: Colors.black54,
      //         child: Text(
      //           'Soc.',
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 48,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 80),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //         child: NeuContainer(
      //           child: Column(
      //             children: [
      //               SocForm(
      //                 label: 'Email',
      //                 onChanged: (value) {},
      //               ),
      //               const SizedBox(height: 20),
      //               SocForm(
      //                 label: 'Password',
      //                 obscure: true,
      //                 onChanged: (value) {},
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       SocButton(
      //         onPressed: () {
      //           print('object1');
      //         },
      //         label: 'Login',
      //       ),
      //       const SizedBox(height: 20),
      //       SocButton(
      //         onPressed: () {},
      //         label: 'Register',
      //         color: Colors.blue.shade100,
      //       ),
      //       const SizedBox(height: 20),
      //       // SocButton(
      //       //   onPressed: () {},
      //       //   width: 290,
      //       //   prefix: const Icon(Icons.mail_outline_rounded),
      //       //   label: 'Register with email',
      //       //   color: Colors.red.shade300,
      //       // ),
      //     ],
      //   ),
      // ),
      body: App(),
    );
  }
}
