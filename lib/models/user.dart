// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? id;
  String? fullName;
  String? username;
  String? profilePic;
  User({
    this.id,
    this.fullName,
    this.username,
    this.profilePic,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        username: json["username"],
        profilePic: json["profilePic"],
      );
}
