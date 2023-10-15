import 'package:soc_app/core/network/graphql_module.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  GraphQLModule get graphQLModule => GraphQLModuleImpl();
}
