import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  String? _id;
  String? _fullName;
  String? _username;
  String? _profilePic;
  List<FriendRequst>? _friendRequestSent = [];
  List<FriendRequst>? _friendRequestReceived = [];
  List<User>? _friends = [];
  String? _fcmToken;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get profilePic => _profilePic;
  List<FriendRequst> get friendRequestSent => _friendRequestSent ?? [];
  List<FriendRequst> get friendRequestReceived => _friendRequestReceived ?? [];
  List<User> get friends => _friends ?? [];
  String? get fcmToken => _fcmToken;

  void setProfile(User user) {
    _id = user.id;
    _fullName = user.fullName;
    _username = user.username;
    _profilePic = user.profilePic;
    _friendRequestSent = user.friendRequestSent;
    _friendRequestReceived = user.friendRequestReceived;
    _friends = user.friends;
    _fcmToken = user.fcmToken;
    notifyListeners();
  }

  void updateProfile(User user) {
    if (user.profilePic != null) {
      _profilePic = user.profilePic;
    }
    _fullName = user.fullName;
    notifyListeners();
  }

  void updateFcmToken(String token) {
    _fcmToken = token;
  }

  void addFriendRequest(User user) {
    _friendRequestSent?.add(FriendRequst(
      user: user,
      status: "pending",
    ));
    notifyListeners();
  }

  void addReceivedFriendRequest(User user) {
    _friendRequestReceived?.add(FriendRequst(
      user: user,
      status: "pending",
    ));
    notifyListeners();
  }

  void friendRequestAccepted(User user) {
    _friendRequestSent?.removeWhere((request) => request.user?.id == user.id);
    _friends?.add(user);
    notifyListeners();
  }

  void friendRequestRejected(User user) {
    _friendRequestSent?.removeWhere((request) => request.user?.id == user.id);
    notifyListeners();
  }

  void acceptFriendRequest(User? user) {
    if (user != null) {
      friends.add(user);
      friendRequestReceived
          .removeWhere((request) => request.user?.id == user.id);
      notifyListeners();
    }
  }

  void rejectFriendRequest(User? user) {
    if (user != null) {
      friendRequestReceived
          .removeWhere((request) => request.user?.id == user.id);
      notifyListeners();
    }
  }

  void unfriendUser(User? user) {
    if (user != null) {
      friends.removeWhere((friend) => friend.id == user.id);
      notifyListeners();
    }
  }

  User toUser() {
    return User(
      id: id,
      fullName: fullName!,
      username: username!,
      profilePic: profilePic,
    );
  }

  void reset() {
    _id = null;
    _fullName = null;
    _username = null;
    _profilePic = null;
    _friendRequestSent = [];
    _friendRequestReceived = [];
    _friends = [];
    _fcmToken = null;
    notifyListeners();
  }
}
