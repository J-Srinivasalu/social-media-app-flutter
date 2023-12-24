import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  final postRefreshController = RefreshController(initialRefresh: true);

  int _offset = 0;
  bool isLoading = false;

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void initialize() {}

  void logout() {
    _navigationService.clearStackAndShow(Routes.loginViewRoute);
  }

  Future<void> fetchPosts(PostProvider postProvider) async {
    updateIsLoading(true);
    try {
      final response = await _apiService.getPosts(offset: _offset, limit: 10);
      if (response.isSuccessful()) {
        dynamic postsJson = response.responseGeneral.detail?.data["posts"];
        List<Post> posts =
            List<Post>.from(postsJson.map((post) => Post.fromMap(post)));
        if (posts.isEmpty) {
          postRefreshController.loadNoData();
        } else {
          _offset += 10;
          postProvider.addPosts(posts);
        }
        postRefreshController.loadComplete();
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      postRefreshController.loadFailed();
    } finally {
      updateIsLoading(false);
    }
  }

  Future<void> refreshPosts(PostProvider postProvider) async {
    updateIsLoading(true);
    try {
      final response = await _apiService.getPosts(offset: 0, limit: 10);
      if (response.isSuccessful()) {
        _offset = 0;
        postProvider.resetPosts();
        dynamic postsJson = response.responseGeneral.detail?.data["posts"];
        List<Post> posts =
            List<Post>.from(postsJson.map((post) => Post.fromMap(post)));

        _offset += 10;
        postProvider.addPosts(posts);
        postRefreshController.refreshCompleted();
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      postRefreshController.refreshFailed();
    } finally {
      updateIsLoading(false);
    }
  }
}
