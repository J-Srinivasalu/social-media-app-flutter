import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _apiService = locator<ApiService>();
  final nameController = TextEditingController();

  String newProfilePic = '';

  Future<void> updateProfile(ProfileProvider profileProvider) async {
    try {
      final name = nameController.text;
      if (profileProvider.fullName != name || newProfilePic.isNotEmpty) {
        final response =
            await runBusyFuture(_apiService.updateUser(name, newProfilePic));
        if (response.isSuccessful()) {
          User user =
              User.fromMap(response.responseGeneral.detail?.data["user"]);
          profileProvider.setProfile(
              User(fullName: user.fullName, profilePic: user.profilePic));
          newProfilePic = '';
          notifyListeners();
          _navigationService
              .clearStackAndShowView(const BottomNavbarView(viewIndex: 1));
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

  void initialize(ProfileProvider profileProvider) {
    nameController.text = profileProvider.fullName ?? "";
    notifyListeners();
  }

  void updateProfilePic(File file) {
    newProfilePic = file.path;
    notifyListeners();
  }
}
