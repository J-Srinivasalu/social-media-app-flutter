// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'user.dart';

class Chat {
  String? id;
  List<User> participents;
  ChatMessage? lastMessage;
  int offset = 0;
  DateTime? updatedAt;
  DateTime? createdAt;
  Chat({
    this.id,
    this.participents = const [],
    this.lastMessage,
    this.updatedAt,
    this.createdAt,
  });

  factory Chat.fromJson(String str) => Chat.fromMap(json.decode(str));

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        participents:
            List<User>.from(json["participants"].map((x) => User.fromMap(x))),
        lastMessage: ChatMessage.fromMap(json["lastMessage"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "participants":
            participents.map((participant) => participant.toMap()).toList(),
        "lastMessage": lastMessage,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class ChatMessage {
  String? id;
  String? chat;
  User? sender;
  String? content;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  ChatMessage({
    this.id,
    this.chat,
    this.sender,
    this.content,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  factory ChatMessage.fromJson(String str) =>
      ChatMessage.fromMap(json.decode(str));

  factory ChatMessage.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ChatMessage();
    final senderJson = json["sender"];
    var sender = senderJson.runtimeType == String
        ? User(id: senderJson)
        : User.fromMap(json["sender"]);
    return ChatMessage(
      id: json["_id"],
      chat: json["chat"],
      sender: sender,
      content: json["content"],
      status: json["status"],
      updatedAt: DateTime.parse(json["updatedAt"]),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "chat": chat,
        "sender": sender?.toMap(),
        "content": content,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
