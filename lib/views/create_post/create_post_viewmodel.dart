import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final postContentController = TextEditingController();
  String _visibleTo = "Everyone";

  String get visibleTo => _visibleTo;

  void setVisibleTo(int option) {
    switch (option) {
      case 0:
        _visibleTo = "Everyone";
        break;
      case 1:
        _visibleTo = "Only Friends";
        break;
      default:
        _visibleTo = "Everyone";
        break;
    }
    notifyListeners();
  }

  void navigateBack() {
    _navigationService.back();
  }

  void uploadPost(PostProvider postProvider, ProfileProvider profileProvider) {
    postProvider.addPost(
      Post(
        user: profileProvider.toUser(),
        content: postContentController.text,
        media: [],
        likes: [],
        comments: [],
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    );
    navigateBack();
  }
}
