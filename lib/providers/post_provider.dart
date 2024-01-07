import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  void addPosts(List<Post> postList) {
    _posts.addAll(postList);
    notifyListeners();
  }

  void likePost(String id, String userId) {
    _posts.firstWhere((element) => element.id == id).likes.add(userId);
    notifyListeners();
  }

  void addComment(String id) {
    _posts.firstWhere((element) => element.id == id).comments += 1;
    notifyListeners();
  }

  void addPost(Post post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void reset() {
    _posts.clear();
    notifyListeners();
  }
}
