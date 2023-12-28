import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked/stacked.dart';

class FriendRequestViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  acceptFriendRequest(ProfileProvider profileProvider, User? user) async {
    try {
      if (user != null) {
        final response =
            await runBusyFuture(_apiService.acceptFriendRequest(user.id!));
        if (response.isSuccessful()) {
          profileProvider.acceptFriendRequest(user);
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

  rejectFriendRequest(ProfileProvider profileProvider, User? user) async {
    try {
      if (user != null) {
        final response =
            await runBusyFuture(_apiService.rejectFriendRequest(user.id!));
        if (response.isSuccessful()) {
          profileProvider.rejectFriendRequest(user);
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
