import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/notification_action.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/firebase_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/socket_io_service.dart';
import 'package:social_media_app/utils/socket_events.dart';
import 'package:social_media_app/views/chat/chats_view.dart';
import 'package:social_media_app/views/chat/individual_chat_view.dart';
import 'package:social_media_app/views/create_post/create_post_view.dart';
import 'package:stacked/stacked.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavbarViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  final _socketIOService = locator<SocketIOService>();
  final _sharedPreferences = locator<SharedPreferenceService>();

  final homePageKey = GlobalKey<NavigatorState>();
  final profilePageKey = GlobalKey<NavigatorState>();

  int index = 0;

  bool serverDown = false;

  void initialize(
    int viewIndex,
    ProfileProvider profileProvider,
    PostProvider postProvider,
    Map<String, String>? data,
    ChatProvider chatProvider,
    NotificationAction? notificationAction,
  ) async {
    switchScreen(viewIndex);
    Timer(const Duration(seconds: 10), () {
      serverDown = true;
      notifyListeners();
    });
    await runBusyFuture(setProfileProvider(profileProvider));

    initFirebaseNotification(
      profileProvider,
      chatProvider,
      (data) => doWhenInForeground(data, profileProvider),
    );
    await setChatProvider(chatProvider);
    final token = _sharedPreferences.getToken();
    _socketIOService.initializeSocketIO(token);

    if (notificationAction?.action == "message") {
      final data = notificationAction?.data;
      _navigationService.navigateToView(IndividualChatView(
        friend: User(
          id: data?["id"],
          fullName: data?["fullName"],
          username: data?["username"],
          profilePic: data?["profilePic"],
        ),
        chatId: data?["chatId"],
      ));
    }
    _socketIOService.socket?.on(ChatEventEnum.NEW_CHAT_EVENT, (chat) {
      debugPrint(
          "${ChatEventEnum.NEW_CHAT_EVENT} ${json.encode(chat).toString()}");
      chatProvider.updateChats([Chat.fromMap(chat)]);
    });
    _socketIOService.socket?.on(ChatEventEnum.MESSAGE_RECEIVED_EVENT,
        (message) {
      debugPrint("${ChatEventEnum.MESSAGE_RECEIVED_EVENT} $message");
      chatProvider.updateLastMessage(ChatMessage.fromMap(message));
    });
    _socketIOService.socket?.on(
      ChatEventEnum.USER_ONLINE_EVENT,
      (userId) {
        debugPrint("${ChatEventEnum.USER_ONLINE_EVENT} $userId");
        chatProvider.updateUserStatus(userId, true);
      },
    );
    _socketIOService.socket?.on(
      ChatEventEnum.USER_OFFLINE_EVENT,
      (userId) {
        debugPrint("${ChatEventEnum.USER_OFFLINE_EVENT} $userId");
        chatProvider.updateUserStatus(userId, false);
      },
    );
  }

  void switchScreen(int i) {
    if (index == i) {
      switch (i) {
        case 0:
          homePageKey.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          profilePageKey.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      index = i;
    }
    notifyListeners();
  }

  void updateIndex(i) {
    index = i;
    notifyListeners();
  }

  void navigateToCreatePost() {
    _navigationService.navigateToView(const CreatePostView());
  }

  void doWhenInForeground(
    Map<String, dynamic> data,
    ProfileProvider profileProvider,
  ) {
    debugPrint("SMA: DoWhenInForeground");
    String action = data["action"];
    String id = data["id"];
    String fullName = data["fullName"];
    String username = data["username"];
    String profilePic = data["profilePic"];
    User user = User(
      id: id,
      fullName: fullName,
      username: username,
      profilePic: profilePic,
    );
    switch (action) {
      case "friend_request":
        profileProvider.addReceivedFriendRequest(user);
        break;
      case "accept_friend":
        profileProvider.friendRequestAccepted(user);
        break;
      case "reject_request":
        profileProvider.friendRequestRejected(user);
        break;
      case "unfriend_request":
        profileProvider.unfriendUser(user);
        break;
      default:
        break;
    }
  }

  Future<void> setProfileProvider(ProfileProvider profileProvider) async {
    try {
      final response = await _apiService.getUser();
      if (response.isSuccessful()) {
        User user = User.fromMap(response.responseGeneral.detail?.data["user"]);
        profileProvider.setProfile(user);
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  Future<void> setChatProvider(ChatProvider chatProvider) async {
    try {
      chatProvider.reset();
      final response = await _apiService.getChats();
      if (response.isSuccessful()) {
        List<Chat> chats = List<Chat>.from(
          response.responseGeneral.detail?.data["chats"]
              .map((chat) => Chat.fromMap(chat)),
        );
        chatProvider.updateChats(chats);
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  void navigateToChats() {
    _navigationService.navigateToView(const ChatsView());
  }
}
