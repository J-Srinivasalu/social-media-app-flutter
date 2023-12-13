// import 'package:stacked/stacked_annotations.dart';

import 'package:social_media_app/services/environment_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/home/home_view.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/register/register_view.dart';
import 'package:social_media_app/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: HomeView, name: 'homeViewRoute'),
  MaterialRoute(page: LoginView, name: 'loginViewRoute'),
  MaterialRoute(page: RegisterView, name: 'registerViewRoute'),
], dependencies: [
  LazySingleton(classType: EnvironmentService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: ToastService),
])
class App {}
