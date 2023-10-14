import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:soc_app/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

// use get it as dependency injection library so we cut the boilerplate codes
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
