// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'user.dart';

class Post {
  String? id;
  User? user;
  String? content;
  List<String> medias;
  List<String> likes;
  int comments = 0;
  DateTime? updatedAt;
  DateTime? createdAt;
  Post({
    this.id,
    this.user,
    this.content,
    this.medias = const [],
    this.likes = const [],
    this.comments = 0,
    this.updatedAt,
    this.createdAt,
  });

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["_id"],
        user: User.fromMap(json["user"]),
        content: json["content"],
        medias: List<String>.from(json["medias"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        comments: json["comments"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
