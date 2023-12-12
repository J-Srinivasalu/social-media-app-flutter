import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  initialize() {
    Future.delayed(const Duration(seconds: 2), () {
      _navigationService.clearStackAndShow(Routes.homeViewRoute);
    });
  }
}
