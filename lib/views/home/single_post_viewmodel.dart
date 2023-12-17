import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SinglePostViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final commentController = TextEditingController();

  void likeComment(Comment comment, String? username) {
    if (username == null) return;
    if (!comment.likes.contains(username)) {
      comment.likes.add(username);
    } else {
      comment.likes.removeWhere((element) => element == username);
    }
    notifyListeners();
  }

  void uploadComment(Post post, ProfileProvider profileProvider) {
    if (commentController.text.isEmpty) {
      return;
    }
    post.comments.add(
      Comment(
        user: profileProvider.toUser(),
        content: commentController.text,
        likes: [],
      ),
    );
    commentController.clear();
    notifyListeners();
  }

  void navigateToPublicProfile(User user) {
    _navigationService
        .navigateToView(PublicProfileView(userPublicProfile: user));
  }
}
