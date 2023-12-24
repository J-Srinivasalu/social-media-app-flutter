import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked/stacked.dart';

class PublicProfileViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  final postRefreshController = RefreshController(initialRefresh: false);

  User user = User(fullName: "");
  final List<Post> _posts = [];

  List<Post> get posts => _posts
    ..sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return b.createdAt!.compareTo(a.createdAt!);
    });

  void initialize(User userPublicProfile) {
    user = userPublicProfile;
    runBusyFuture(fetchPosts());
  }

  int _offset = 0;

  void updateOffset() {
    _offset += 10;
    notifyListeners();
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
}
