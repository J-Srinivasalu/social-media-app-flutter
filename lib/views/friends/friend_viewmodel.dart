import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FriendViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  void navigateToPublicProfile(User? user) {
    if (user != null) {
      _navigationService
          .navigateToView(PublicProfileView(userPublicProfile: user));
    } else {
      _toastService.callToast("User not found");
    }
  }

  void unfriendUser(ProfileProvider profileProvider, User? user) async {
    try {
      if (user != null) {
        final response =
            await runBusyFuture(_apiService.sendUnfriendRequest(user.id!));
        if (response.isSuccessful()) {
          profileProvider.unfriendUser(user);
          notifyListeners();
        } else {
          _toastService.callToast(response.responseGeneral.detail!.message);
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }
}
