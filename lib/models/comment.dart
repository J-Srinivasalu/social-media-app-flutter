// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'user.dart';

class Comment {
  String? id;
  String? postId;
  User? user;
  String? content;
  List<String> likes;
  DateTime? updatedAt;
  DateTime? createdAt;
  Comment({
    this.id,
    this.postId,
    this.user,
    this.content,
    this.likes = const [],
    this.updatedAt,
    this.createdAt,
  });

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        postId: json["postId"],
        user: User.fromMap(json["user"]),
        content: json["content"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
