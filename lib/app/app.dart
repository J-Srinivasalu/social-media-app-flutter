// import 'package:stacked/stacked_annotations.dart';

import 'package:social_media_app/services/environment_service.dart';
import 'package:social_media_app/views/home/home_view.dart';
import 'package:social_media_app/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: HomeView, name: 'homeViewRoute'),
], dependencies: [
  LazySingleton(classType: EnvironmentService),
  LazySingleton(classType: NavigationService)
])
class App {}
