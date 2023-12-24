import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();

  final postContentController = TextEditingController();
  String _visibleTo = "Everyone";

  final List<File> _attachments = [];

  List<File> get attachments => _attachments;

  String get visibleTo => _visibleTo;

  void addAttachment(File file) {
    _attachments.add(file);
    notifyListeners();
  }

  void removeAttachment(int index) {
    debugPrint(index.toString());
    _attachments.removeAt(index);
    notifyListeners();
  }

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

  Future<void> uploadPost(
      PostProvider postProvider, ProfileProvider profileProvider) async {
    final List<String> mediaPaths =
        attachments.map((file) => file.path).toList();
    final String content = postContentController.text;
    try {
      final response =
          await runBusyFuture(_apiService.uploadPost(mediaPaths, content));
      if (response.isSuccessful()) {
        final Post post =
            Post.fromMap(response.responseGeneral.detail!.data["post"]);
        postProvider.addPost(post);
        navigateBack();
      }
      notifyListeners();
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }
}
