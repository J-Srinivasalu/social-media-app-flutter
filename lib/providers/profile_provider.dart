import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  String? _id;
  String? _email;
  String? _fullName;
  String? _username;
  String? _profileImage;

  String? get id => _id;
  String? get email => _email;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get profileImage => _profileImage;

  void setProfile(User user) {
    _id = user.id;
    _email = user.email;
    _fullName = user.fullName;
    _username = user.username;
    _profileImage = user.profileImage;
  }

  void updateProfile(User user) {
    if (user.profileImage != null) {
      _profileImage = user.profileImage;
    }
    _fullName = user.fullName;
  }

  User toUser() {
    return User(fullName: fullName!, username: username!);
  }
}
