import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/views/create_post/create_post_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavbarViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final homePageKey = GlobalKey<NavigatorState>();
  final profilePageKey = GlobalKey<NavigatorState>();

  int index = 0;

  void initialize(int viewIndex) {
    switchScreen(viewIndex);
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
}
