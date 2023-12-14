import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:social_media_app/views/register/register_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    _navigationService
        .clearStackAndShowView(const BottomNavbarView(viewIndex: 0));
  }

  void navigateToRegister() {
    _navigationService.clearStackAndShowView(const RegisterView());
  }
}
