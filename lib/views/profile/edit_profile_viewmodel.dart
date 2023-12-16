import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends BaseViewModel {
  final nameController = TextEditingController();

  void updateProfile(ProfileProvider profileProvider) {
    final name = nameController.text;
    if (profileProvider.fullName != name) {
      profileProvider.setProfile(User(fullName: name));
    }
  }
}
