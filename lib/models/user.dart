// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  String? id;
  String? fullName;
  String? username;
  String? profilePic;
  List<FriendRequst>? friendRequestSent;
  List<FriendRequst>? friendRequestReceived;
  List<User>? friends;

  User({
    this.id,
    this.fullName,
    this.username,
    this.profilePic,
    this.friendRequestSent = const [],
    this.friendRequestReceived = const [],
    this.friends = const [],
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) {
    final friendRequestReceived = json["friendRequestReceived"] != null
        ? List<FriendRequst>.from(
            json["friendRequestReceived"]
                .map((request) => FriendRequst.fromMap(request)),
          )
        : null;

    final friendRequestSent = json["friendRequestSent"] != null
        ? List<FriendRequst>.from(
            json["friendRequestSent"]
                .map((request) => FriendRequst.fromMap(request)),
          )
        : null;

    final friends = json["friends"] != null
        ? List<User>.from(json["friends"]?.map(
            (request) => User.fromMap(request),
          ))
        : null;
    return User(
      id: json["_id"],
      fullName: json["fullName"],
      username: json["username"],
      profilePic: json["profilePic"],
      friendRequestReceived: friendRequestReceived,
      friendRequestSent: friendRequestSent,
      friends: friends,
    );
  }
}

class FriendRequst {
  User? user;
  String? status;

  FriendRequst({this.user, this.status});

  factory FriendRequst.fromJson(String str) =>
      FriendRequst.fromMap(json.decode(str));

  factory FriendRequst.fromMap(Map<String, dynamic> json) => FriendRequst(
        user: User.fromMap(json["user"]),
        status: json["status"],
      );
}
