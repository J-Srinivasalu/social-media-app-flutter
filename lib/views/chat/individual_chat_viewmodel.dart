import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/socket_io_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/socket_events.dart';
import 'package:stacked/stacked.dart';

class IndividualChatViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  final _socketIOService = locator<SocketIOService>();
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages.reversed.toList();
  // User? chatWithUser;

  final messageController = TextEditingController();
  final messageRefreshController = RefreshController(initialRefresh: false);
  final messagesScrollController = ScrollController();

  Timer? typingTimer;

  initialize(ProfileProvider profileProvider, ChatProvider chatProvider,
      String chatId) async {
    chatProvider.setCurrentChat(chatId);
    _socketIOService.socket?.emit(ChatEventEnum.JOIN_CHAT_EVENT, chatId);
    chatProvider.chats
            .firstWhere(
              (chat) => chat.id == chatId,
              orElse: () => Chat(
                lastMessage: ChatMessage(
                  sender: profileProvider.toUser(),
                ),
              ),
            )
            .lastMessage
            ?.sender
            ?.id !=
        profileProvider.id;
    {
      _socketIOService.socket
          ?.emit(ChatEventEnum.CHAT_MESSAGES_SEEN_EVENT, chatId);
    }

    _socketIOService.socket?.on(ChatEventEnum.MESSAGE_RECEIVED_EVENT,
        (message) {
      final newMessage = ChatMessage.fromMap(message);
      if (newMessage.chat != chatId) return;
      _messages.insert(0, newMessage);
      notifyListeners();
      _socketIOService.socket
          ?.emit(ChatEventEnum.CHAT_MESSAGES_SEEN_EVENT, chatId);
      moveToLast();
    });
    _socketIOService.socket?.on(ChatEventEnum.MESSAGE_DELIVERED, (chatId) {
      debugPrint("${ChatEventEnum.MESSAGE_DELIVERED} $chatId");
    });
    _socketIOService.socket?.on(ChatEventEnum.CHAT_MESSAGES_SEEN_EVENT,
        (messageId) {
      debugPrint("${ChatEventEnum.CHAT_MESSAGES_SEEN_EVENT} $messageId");
      // need to find a optimal way!
      for (var message in _messages) {
        message.status = MessageStatus.seen;
      }
      notifyListeners();
    });
    _socketIOService.socket?.on(ChatEventEnum.TYPING_EVENT, (id) {
      debugPrint("${ChatEventEnum.TYPING_EVENT} $id");
      if (chatId == id) {
        setTyping(true);
      }
    });
    _socketIOService.socket?.on(ChatEventEnum.STOP_TYPING_EVENT, (id) {
      debugPrint("${ChatEventEnum.STOP_TYPING_EVENT} $id");
      if (chatId == id) {
        setTyping(false);
      }
    });
    messageController.addListener(() {
      sendTypingEvent(chatId);
      debounceStopTyping(chatId);
    });

    runBusyFuture(fetchMessages(chatId)).then((value) => moveToLast());
  }

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  void sendTypingEvent(String chatId) {
    _socketIOService.socket?.emit(ChatEventEnum.TYPING_EVENT, chatId);
  }

  void sendStopTypingEvent(String chatId) {
    _socketIOService.socket?.emit(ChatEventEnum.STOP_TYPING_EVENT, chatId);
  }

  void debounceStopTyping(String chatId) {
    if (typingTimer != null && typingTimer!.isActive) {
      typingTimer!.cancel();
    }

    typingTimer = Timer(const Duration(milliseconds: 2000), () {
      setTyping(false);
      sendStopTypingEvent(chatId);
    });
  }

  void moveToLast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      debugPrint("move to last");
      messagesScrollController.animateTo(
        messagesScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
      );
    });

    notifyListeners();
  }

  clearEverything(ChatProvider chatProvider) {
    chatProvider.setCurrentChat("");
  }

  Future<void> sendMessage(
    User friend,
    String chatId,
    ChatProvider chatProvider,
    ProfileProvider profileProvider,
  ) async {
    debugPrint("Start ${DateTime.now().toIso8601String()}");
    User user = profileProvider.toUser();
    final messageContent = messageController.text;
    messageController.clear();
    _socketIOService.socket?.emit(ChatEventEnum.STOP_TYPING_EVENT, chatId);
    final tempMessageId = "message${DateTime.now().microsecond}";
    var message = ChatMessage(
      id: tempMessageId,
      sender: user,
      content: messageContent,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _messages.insert(0, message);
    notifyListeners();
    moveToLast();
    debugPrint("end ${DateTime.now().toIso8601String()}");
    try {
      final response = await _apiService.sendMessage(chatId, messageContent);
      if (response.isSuccessful()) {
        ChatMessage? newMessage = ChatMessage.fromMap(
            response.responseGeneral.detail?.data["message"]);
        _messages
            .firstWhere(
              (m) => m.id == tempMessageId,
              orElse: () => message,
            )
            .status = newMessage.status;
        _messages
            .firstWhere(
              (m) => m.id == tempMessageId,
              orElse: () => message,
            )
            .id = newMessage.id;
        chatProvider.updateLastMessage(newMessage);
        _socketIOService.socket?.emit(
          ChatEventEnum.NEW_CHAT_EVENT,
          (message.toMap()),
        );
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  int _offset = 0;
  bool isLoading = false;

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchMessages(String chatId) async {
    debugPrint("chatId: $chatId");
    updateIsLoading(true);
    try {
      final response =
          await _apiService.getMessages(chatId, offset: _offset, limit: 10);
      if (response.isSuccessful()) {
        dynamic messagesJson =
            response.responseGeneral.detail?.data["messages"];
        List<ChatMessage> fetchedMessages = List<ChatMessage>.from(
            messagesJson.map((message) => ChatMessage.fromMap(message)));
        if (fetchedMessages.isEmpty) {
          messageRefreshController.loadNoData();
        } else {
          _offset += 10;
          _messages.addAll(fetchedMessages);
        }
        messageRefreshController.refreshCompleted();
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      messageRefreshController.refreshFailed();
    } finally {
      updateIsLoading(false);
      debugPrint("loading finished");
    }
  }
}
