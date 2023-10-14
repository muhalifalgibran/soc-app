import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soc_app/app.dart';
import 'package:soc_app/features/startup/presentation/cubit/startup_cubit.dart';
import 'package:soc_app/features/startup/presentation/page/startup_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soc. App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: BlocProvider(
        create: (context) => StartupCubit()..getLoginStatus(),
        child: const StartupPage(),
      ),
    );
  }
}
