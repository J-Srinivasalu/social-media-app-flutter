// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? id;
  String? fullName;
  String? username;
  String? profilePic;
  List<FriendRequst>? friendRequestSent;
  List<FriendRequst>? friendRequestReceived;
  List<User>? friends;
  bool isOnline = false;
  String? fcmToken;
  DateTime? updatedAt;
  DateTime? createdAt;

  User({
    this.id,
    this.fullName,
    this.username,
    this.profilePic,
    this.friendRequestSent = const [],
    this.friendRequestReceived = const [],
    this.friends = const [],
    this.isOnline = false,
    this.fcmToken,
    this.updatedAt,
    this.createdAt,
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
    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now();
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now();
    return User(
      id: json["_id"],
      fullName: json["fullName"],
      username: json["username"],
      profilePic: json["profilePic"],
      friendRequestReceived: friendRequestReceived,
      friendRequestSent: friendRequestSent,
      friends: friends,
      isOnline: json["isOnline"] ?? false,
      fcmToken: json["fcmToken"],
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() => {
        "_id": id,
        "fullName": fullName,
        "username": username,
        "profilePic": profilePic,
        "isOnline": isOnline,
      };
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
