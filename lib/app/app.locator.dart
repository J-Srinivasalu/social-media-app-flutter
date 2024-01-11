// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/api_service.dart';
import '../services/connectivity_service.dart';
import '../services/environment_service.dart';
import '../services/shared_preference_service.dart';
import '../services/socket_io_service.dart';
import '../services/toast_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => EnvironmentService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ToastService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SocketIOService());
  locator.registerLazySingleton(() => ConnectivityService());
  final sharedPreferenceService = SharedPreferenceService();
  await sharedPreferenceService.init();
  locator.registerSingleton(sharedPreferenceService);
}
