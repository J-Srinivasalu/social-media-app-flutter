import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/socket_io_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/socket_events.dart';
import 'package:social_media_app/views/chat/individual_chat_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewMessageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  // final _socketIOService = locator<SocketIOService>();

  final searchController = TextEditingController();
  final List<User> _friends = [];
  List<User> filteredFriends = [];
  List<User> get friends => filteredFriends;

  void initialize(ProfileProvider profileProvider) {
    _friends.addAll(profileProvider.friends);
    filteredFriends.addAll(_friends);

    searchController.addListener(() {
      debugPrint(searchController.text);
      filteredFriends = searchController.text.isEmpty
          ? _friends
          : _friends
              .where((user) =>
                  user.fullName?.contains(searchController.text) == true ||
                  user.username?.contains(searchController.text) == true)
              .toList();
      notifyListeners();
    });
  }

  navigateToIndividualChat(User user, ChatProvider chatProvider) async {
    try {
      final response =
          await runBusyFuture(_apiService.createOrGetChat(user.id!));
      if (response.isSuccessful()) {
        Chat chat = Chat.fromMap(response.responseGeneral.detail?.data["chat"]);
        if (chat.id == null) {
          throw "Chat doesn't exist";
        }
        if (response.responseGeneral.detail?.statusCode == 201) {
          debugPrint("new Chat: ${chat.id} ${chat.participents[0]}");
          chatProvider.updateChats([chat]);
        }
        debugPrint("old Chat: ${chat.id} ${chat.participents[0]}");
        _navigationService.navigateToView(IndividualChatView(
          friend: user,
          chatId: chat.id!,
        ));
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }
}
