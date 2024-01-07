import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/chat/individual_chat_view.dart';
import 'package:social_media_app/views/chat/new_message_view.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  final chatRefreshController = RefreshController();

  bool isLoading = false;

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchChats(ChatProvider chatProvider) async {
    updateIsLoading(true);
    try {
      final response = await _apiService.getChats(
          offset: chatProvider.chats.length, limit: 10);
      if (response.isSuccessful()) {
        dynamic chatsJson = response.responseGeneral.detail?.data["chats"];
        List<Chat> chats =
            List<Chat>.from(chatsJson.map((chat) => Chat.fromMap(chat)));
        if (chats.isEmpty) {
          chatRefreshController.loadNoData();
        } else {
          chatProvider.updateChats(chats);
        }
        chatRefreshController.loadComplete();
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
      chatRefreshController.loadFailed();
    } finally {
      updateIsLoading(false);
    }
  }

  navigateToIndividualChat(Chat chat, ProfileProvider profileProvider) {
    final friend =
        chat.participents.firstWhere((user) => user.id != profileProvider.id);
    _navigationService.navigateToView(IndividualChatView(
      friend: friend,
      chatId: chat.id!,
    ));
  }

  void navigateToPublicProfile(User user) {
    _navigationService
        .navigateToView(PublicProfileView(userPublicProfile: user));
  }

  void navigateToNewMessage() {
    _navigationService.navigateToView(const NewMessageView());
  }
}
