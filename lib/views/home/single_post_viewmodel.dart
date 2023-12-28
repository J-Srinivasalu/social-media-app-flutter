import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SinglePostViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _apiService = locator<ApiService>();
  final commentController = TextEditingController();

  final commentRefreshController = RefreshController(initialRefresh: true);
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> likePost(
      PostProvider postProvider, Post post, String? userId) async {
    if (post.likes.contains(userId)) return;
    try {
      postProvider.likePost(post.id!, userId!);
      notifyListeners();
      await _apiService.likePost(post.id!);
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> likeComment(int index, String? userId) async {
    if (comments[index].likes.contains(userId!)) return;
    try {
      _comments[index].likes.add(userId);
      notifyListeners();
      await _apiService.likeComment(_comments[index].id!);
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> uploadComment(PostProvider postProvider, Post post,
      ProfileProvider profileProvider) async {
    final comment = commentController.text;
    if (comment.isEmpty) {
      return;
    }

    try {
      final response = await runBusyFuture(
          _apiService.uploadCommentByPost(post.id!, comment));

      if (response.isSuccessful()) {
        Comment newComment =
            Comment.fromMap(response.responseGeneral.detail!.data["comment"]);
        _comments.add(newComment);
        postProvider.addComment(post.id!);
        _offset += 1;
      }
      commentController.clear();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  int _offset = 0;
  void updateOffset() {
    _offset += 10;
    notifyListeners();
  }

  bool isLoading = true;
  void updateIsLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchComments(Post post) async {
    try {
      final response =
          await _apiService.getComments(post.id!, offset: _offset, limit: 10);
      if (response.isSuccessful()) {
        dynamic commentsJson =
            response.responseGeneral.detail?.data["comments"];
        List<Comment> newComments = List<Comment>.from(
            commentsJson.map((comment) => Comment.fromMap(comment)));
        if (newComments.isEmpty) {
          commentRefreshController.loadNoData();
        } else {
          updateOffset();
          _comments.addAll(newComments);
        }
        commentRefreshController.loadComplete();
        notifyListeners();
      }
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      commentRefreshController.refreshFailed();
    }
  }

  Future<void> loadComments(Post post) async {
    _offset = 0;
    _comments.clear();
    try {
      final response =
          await _apiService.getComments(post.id!, offset: _offset, limit: 10);
      if (response.isSuccessful()) {
        dynamic commentsJson =
            response.responseGeneral.detail?.data["comments"];
        List<Comment> newComments = List<Comment>.from(
            commentsJson.map((comment) => Comment.fromMap(comment)));
        updateOffset();
        _comments.addAll(newComments);
        commentRefreshController.refreshCompleted();
        notifyListeners();
      }
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      commentRefreshController.refreshFailed();
    } finally {
      updateIsLoading();
    }
  }

  void navigateToPublicProfile(User? user) {
    if (user != null) {
      _navigationService
          .navigateToView(PublicProfileView(userPublicProfile: user));
    }
  }
}
