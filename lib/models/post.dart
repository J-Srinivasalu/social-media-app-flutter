// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'user.dart';

class Post {
  String? id;
  User user;
  String content;
  List<String> media;
  List<String> likes;
  List<String> comments;
  DateTime? updatedAt;
  DateTime? createdAt;
  Post({
    this.id,
    required this.user,
    required this.content,
    required this.media,
    required this.likes,
    required this.comments,
    this.updatedAt,
    this.createdAt,
  });
}
