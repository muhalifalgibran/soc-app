import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/network/graphql_config.dart';
import 'package:soc_app/features/startup/presentation/page/startup_page.dart';
import 'package:soc_app/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  configureDependencies();

  await Hive.initFlutter();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLConfig.client(),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiBlocProvider(
        providers: Injection.instance.initBloc(),
        child: MaterialApp(
          title: 'Soc. App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const StartupPage(),
        ),
      ),
    );
  }
}
