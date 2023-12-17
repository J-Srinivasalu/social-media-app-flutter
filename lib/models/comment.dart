// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'user.dart';

class Comment {
  String? id;
  User user;
  String content;
  List<String> likes;
  DateTime? updatedAt;
  DateTime? createdAt;
  Comment({
    this.id,
    required this.user,
    required this.content,
    required this.likes,
    this.updatedAt,
    this.createdAt,
  });
}
