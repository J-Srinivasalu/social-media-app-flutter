import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  String? _id;
  String? _fullName;
  String? _username;
  String? _profilePic;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get profilePic => _profilePic;

  void setProfile(User user) {
    _id = user.id;
    _fullName = user.fullName;
    _username = user.username;
    _profilePic = user.profilePic;
    notifyListeners();
  }

  void updateProfile(User user) {
    if (user.profilePic != null) {
      _profilePic = user.profilePic;
    }
    _fullName = user.fullName;
    notifyListeners();
  }

  User toUser() {
    return User(fullName: fullName!, username: username!);
  }
}
