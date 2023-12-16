import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/dummy_data.dart';
import 'package:social_media_app/views/create_post/create_post_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavbarViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final homePageKey = GlobalKey<NavigatorState>();
  final profilePageKey = GlobalKey<NavigatorState>();

  int index = 0;

  void initialize(int viewIndex, ProfileProvider profileProvider,
      PostProvider postProvider) {
    switchScreen(viewIndex);

    profileProvider.setProfile(
      User(fullName: "Jack", username: "@jack"),
    );
    List<Post> posts = DummyData.posts;
    postProvider.addPosts(posts);
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
