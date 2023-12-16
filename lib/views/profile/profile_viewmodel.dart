import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void logout() {
    _navigationService.clearStackAndShowView(const LoginView());
  }
}
