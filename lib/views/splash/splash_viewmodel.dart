import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool isSignedIn = false;

  initialize() {
    Future.delayed(const Duration(seconds: 2), () {
      if (isSignedIn) {
        // _navigationService.clearStackAndShow(Routes.registerViewRoute);
        _navigationService
            .clearStackAndShowView(const BottomNavbarView(viewIndex: 0));
      } else {
        _navigationService.clearStackAndShowView(const LoginView());
      }
    });
  }
}
