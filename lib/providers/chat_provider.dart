import 'package:flutter/material.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> _chats = [];
  Chat? _currentChat;
  bool _areChatsLoading = false;

  List<Chat> get chats => _chats;
  Chat? get currentChat => _currentChat;
  bool get areChatsLoading => _areChatsLoading;

  void updateLastMessage(ChatMessage message) {
    debugPrint("message ${message.toMap()}");
    _chats.firstWhere(
      (chat) => chat.id == message.chat,
      orElse: () {
        debugPrint("chat not found");
        return Chat();
      },
    ).lastMessage = message;
    notifyListeners();
  }

  void updateUserStatus(String userId, bool isOnline) {
    for (var chat in _chats) {
      if (chat.participents.contains(User(id: userId))) {
        chat.participents.firstWhere((user) => user.id == userId).isOnline =
            isOnline;
        chat.participents.firstWhere((user) => user.id == userId).updatedAt =
            DateTime.now();
      }
    }
    notifyListeners();
  }

  // void updateChatId(String tempChatId, String chatId) {
  //   Chat chat = _chats.firstWhere((chat) => chat.id == tempChatId,
  //       orElse: () => Chat());
  //   if (chat.id != null) {
  //     chat.id = chatId;
  //     notifyListeners();
  //   }
  // }

  // void updateMessageId(String chatId, String tempMessageId, String messageId) {
  //   Chat chat =
  //       _chats.firstWhere((chat) => chat.id == chatId, orElse: () => Chat());
  //   if (chat.id != null) {
  //     try {
  //       chat.messages.firstWhere((message) => message.id == tempMessageId).id =
  //           messageId;
  //     } catch (error) {
  //       debugPrint(error.toString());
  //     }
  //     notifyListeners();
  //   }
  // }

  void updateChats(List<Chat> newChats) {
    _chats.addAll(newChats);
    notifyListeners();
  }

  // void addChat(Chat newChat, User friend) {}

  // void addMessagesToChat(String chatId, List<Message> messages) {
  //   Chat chat =
  //       _chats.firstWhere((chat) => chat.id == chatId, orElse: () => Chat());

  //   if (chat.id != null) {
  //     chat.messages.addAll(messages);
  //     chat.offset += messages.length;
  //     notifyListeners();
  //   } else {
  //     debugPrint("Chat with ID $chatId not found");
  //   }
  // }

  void setCurrentChat(String chatId) {
    Chat chat =
        _chats.firstWhere((chat) => chat.id == chatId, orElse: () => Chat());
    if (chat.id != null) {
      _currentChat = chat;
      notifyListeners();
    } else {
      debugPrint("Chat with ID $chatId not found");
    }
  }

  void udpateIsChatLoading(bool value) {
    _areChatsLoading = value;
    notifyListeners();
  }

  void reset() {
    _chats.clear();
    _currentChat = null;
    _areChatsLoading = false;
  }
}
