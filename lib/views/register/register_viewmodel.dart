import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  final _sharedPreferenceService = locator<SharedPreferenceService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    try {
      final fullName = nameController.text;
      final email = emailController.text;
      final username = usernameController.text;
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;
      if (password != confirmPassword) {
        _toastService.callToast("Password doesn't match!");
      }
      final response = await runBusyFuture(
        _apiService.registerUser(fullName, username, email, password),
      );

      if (response.isSuccessful()) {
        final token = response.responseGeneral.detail?.data['token'];
        debugPrint(token);
        if (token != null) {
          _sharedPreferenceService.setToken(token);
          Future.delayed(Duration.zero, () {
            _navigationService
                .clearStackAndShowView(const BottomNavbarView(viewIndex: 0));
          });
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  void navigateToLogin() {
    _navigationService.clearStackAndShowView(LoginView());
  }
}
