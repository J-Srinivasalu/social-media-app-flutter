import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void logout() {
    _navigationService.clearStackAndShow(Routes.loginViewRoute);
  }
}
