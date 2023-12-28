import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/firebase_service.dart';
import 'package:social_media_app/views/create_post/create_post_view.dart';
import 'package:stacked/stacked.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavbarViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  final homePageKey = GlobalKey<NavigatorState>();
  final profilePageKey = GlobalKey<NavigatorState>();

  int index = 0;

  void initialize(int viewIndex, ProfileProvider profileProvider,
      PostProvider postProvider, Map<String, String>? data) async {
    switchScreen(viewIndex);
    await runBusyFuture(setProfileProvider(profileProvider));
    initFirebaseNotification(
        (data) => doWhenInForeground(data, profileProvider));
  }

  void switchScreen(int i) {
    if (index == i) {
      switch (i) {
        case 0:
          homePageKey.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          profilePageKey.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      index = i;
    }
    notifyListeners();
  }

  void updateIndex(i) {
    index = i;
    notifyListeners();
  }

  void navigateToCreatePost() {
    _navigationService.navigateToView(const CreatePostView());
  }

  void doWhenInForeground(
    Map<String, dynamic> data,
    ProfileProvider profileProvider,
  ) {
    debugPrint("SMA: DoWhenInForeground");
    String action = data["action"];
    String id = data["id"];
    String fullName = data["fullName"];
    String username = data["username"];
    String profilePic = data["profilePic"];
    User user = User(
      id: id,
      fullName: fullName,
      username: username,
      profilePic: profilePic,
    );
    switch (action) {
      case "friend_request":
        profileProvider.addReceivedFriendRequest(user);
        break;
      case "accept_friend":
        profileProvider.friendRequestAccepted(user);
        break;
      case "reject_request":
        profileProvider.friendRequestRejected(user);
        break;
      case "unfriend_request":
        profileProvider.unfriendUser(user);
        break;
      default:
        break;
    }
  }

  Future<void> setProfileProvider(ProfileProvider profileProvider) async {
    try {
      final response = await _apiService.getUser();
      if (response.isSuccessful()) {
        User user = User.fromMap(response.responseGeneral.detail?.data["user"]);
        profileProvider.setProfile(user);
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }
}
