import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    _navigationService.clearStackAndShow(Routes.homeViewRoute);
  }

  void navigateToLogin() {
    _navigationService.clearStackAndShow(Routes.loginViewRoute);
  }
}
