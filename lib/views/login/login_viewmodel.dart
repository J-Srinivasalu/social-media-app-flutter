import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:social_media_app/views/register/register_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  final _sharedPreferenceService = locator<SharedPreferenceService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      final response =
          await runBusyFuture(_apiService.loginUser(email, password));

      if (response.isSuccessful()) {
        final token = response.responseGeneral.detail?.data['token'];
        final refreshToken =
            response.responseGeneral.detail?.data['refreshToken'];
        debugPrint(token);
        if (token != null) {
          _sharedPreferenceService.setToken(token);
          _sharedPreferenceService.setRefreshToken(refreshToken);
          _navigationService
              .clearStackAndShowView(const BottomNavbarView(viewIndex: 0));
        }
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  void navigateToRegister() {
    _navigationService.clearStackAndShowView(RegisterView());
  }
}
