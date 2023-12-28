import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/public_profile.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked/stacked.dart';

class PublicProfileViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  final postRefreshController = RefreshController(initialRefresh: false);

  PublicProfile user = PublicProfile();
  final List<Post> _posts = [];

  List<Post> get posts => _posts
    ..sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return b.createdAt!.compareTo(a.createdAt!);
    });

  void initialize(User userPublicProfile) async {
    user = PublicProfile(
      id: userPublicProfile.id,
      fullName: userPublicProfile.fullName,
      username: userPublicProfile.username,
      profilePic: userPublicProfile.profilePic,
    );
    await runBusyFuture(getPublicProfile());
    await runBusyFuture(fetchPosts());
  }

  int _offset = 0;

  void updateOffset() {
    _offset += 10;
    notifyListeners();
  }

  Future<void> getPublicProfile() async {
    try {
      final response =
          await runBusyFuture(_apiService.getPublicProfile(user.id!));
      if (response.isSuccessful()) {
        dynamic publicProfileMap =
            response.responseGeneral.detail?.data["user"];
        PublicProfile publicProfile = PublicProfile.fromMap(publicProfileMap);
        user = publicProfile;
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> fetchPosts() async {
    try {
      final response = await runBusyFuture(
          _apiService.getPostsByUser(user.id!, offset: _offset, limit: 10));
      if (response.isSuccessful()) {
        dynamic postsJson = response.responseGeneral.detail?.data["posts"];
        List<Post> fetchedPosts =
            List<Post>.from(postsJson.map((post) => Post.fromMap(post)));
        if (fetchedPosts.isEmpty) {
          postRefreshController.loadNoData();
        } else {
          updateOffset();
          _posts.addAll(fetchedPosts);
        }
        postRefreshController.loadComplete();
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> sendUnfriendRequest(ProfileProvider profileProvider) async {
    try {
      final response =
          await runBusyFuture(_apiService.sendUnfriendRequest(user.id!));
      if (response.isSuccessful()) {
        profileProvider.friends.removeWhere((friend) => friend.id == user.id);
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> sendFriendRequest(
      ProfileProvider profileProvider, User userPublicProfile) async {
    try {
      final response =
          await runBusyFuture(_apiService.sendFriendRequest(user.id!));
      if (response.isSuccessful()) {
        profileProvider.addFriendRequest(userPublicProfile);
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }
}
