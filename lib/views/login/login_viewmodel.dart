import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    _navigationService.clearStackAndShow(Routes.homeViewRoute);
  }

  void navigateToRegister() {
    _navigationService.clearStackAndShow(Routes.registerViewRoute);
  }
}
