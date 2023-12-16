import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts
    ..sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return b.createdAt!.compareTo(a.createdAt!);
    });

  void addPosts(List<Post> postList) {
    _posts.addAll(postList);
    notifyListeners();
  }

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }
}
