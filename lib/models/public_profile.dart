import 'dart:convert';

class PublicProfile {
  String? id;
  String? fullName;
  String? username;
  String? profilePic;
  int friends;

  PublicProfile({
    this.id,
    this.fullName,
    this.username,
    this.profilePic,
    this.friends = 0,
  });

  factory PublicProfile.fromJson(String str) =>
      PublicProfile.fromMap(json.decode(str));

  factory PublicProfile.fromMap(Map<String, dynamic> json) => PublicProfile(
        id: json["_id"],
        fullName: json["fullName"],
        username: json["username"],
        profilePic: json["profilePic"],
        friends: json["friends"],
      );
}
