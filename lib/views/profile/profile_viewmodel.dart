import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/friends/friend_requests_view.dart';
import 'package:social_media_app/views/friends/friend_view.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/profile/edit_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _apiService = locator<ApiService>();
  final _sharedPreferenceService = locator<SharedPreferenceService>();

  void logout(ProfileProvider profileProvider, PostProvider postProvider,
      ChatProvider chatProvider) async {
    try {
      final response = await _apiService.logout();
      if (!response.isSuccessful()) {
        throw Exception([response.responseGeneral.detail?.message]);
      }
      _sharedPreferenceService.setToken("");
      _sharedPreferenceService.setRefreshToken("");
      profileProvider.reset();
      postProvider.reset();
      chatProvider.reset();
      _navigationService.clearStackAndShowView(LoginView());
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  void navigateToEditProfile() {
    _navigationService.navigateToView(const EditProfileView());
  }

  void navigateToFriendRequestView() {
    _navigationService.navigateToView(const FriendRequestView());
  }

  void navigateToFriendView() {
    _navigationService.navigateToView(const FriendView());
  }
}
