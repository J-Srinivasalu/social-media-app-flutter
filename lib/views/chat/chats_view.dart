import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/helper_functions.dart';
import 'package:social_media_app/widgets/refresh_widget.dart';
import 'package:stacked/stacked.dart';

import 'chats_viewmodel.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return ViewModelBuilder<ChatsViewModel>.reactive(
        builder: (context, model, child) => LoadingOverlay(
              isLoading: model.isBusy,
              progressIndicator: const CircularProgressIndicator(),
              color: Colors.black,
              opacity: 0.2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Chats"),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => model.navigateToNewMessage(),
                  shape: const CircleBorder(),
                  backgroundColor: CustomColors.primaryColor,
                  child: const Icon(
                    Icons.edit_square,
                    color: Colors.white,
                  ),
                ),
                body: SafeArea(
                  child: chatProvider.chats.isEmpty
                      ? const Center(
                          child: Text("No Chats", textAlign: TextAlign.center),
                        )
                      : SmartRefresher(
                          enablePullDown: false,
                          enablePullUp: true,
                          controller: model.chatRefreshController,
                          footer: const RefreshWidget(),
                          onLoading: () async {
                            if (!model.isLoading) {
                              await model.fetchChats(chatProvider);
                            }
                          },
                          child: ListView.builder(
                            itemCount: chatProvider.chats.length,
                            itemBuilder: (context, index) => _chatTile(
                              model,
                              chatProvider,
                              index,
                              profileProvider,
                            ),
                          ),
                        ),
                ),
              ),
            ),
        viewModelBuilder: () => ChatsViewModel());
  }
}

_chatTile(ChatsViewModel model, ChatProvider chatProvider, int index,
    ProfileProvider profileProvider) {
  User chatWithUser = chatProvider.chats[index].participents
      .firstWhere((user) => profileProvider.id != user.id);
  ChatMessage? lastMessage = chatProvider.chats[index].lastMessage;

  return Column(
    children: [
      InkWell(
        onTap: () => model.navigateToIndividualChat(
          chatProvider.chats[index],
          profileProvider,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: CustomColors.blueLightColor,
                onTap: () {
                  model.navigateToPublicProfile(chatWithUser);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.primaryColor),
                      child: CachedNetworkImage(
                        imageUrl: chatWithUser.profilePic ?? "",
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              color: CustomColors.whiteColor,
                            ),
                          );
                        },
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (chatWithUser.isOnline)
                      Positioned(
                        bottom: 5.857864,
                        right: 5.857864,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.vibrantGreenColor,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.vibrantGreenColor,
                                spreadRadius: 2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            chatWithUser.fullName ?? "",
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const Text(
                            " · ",
                            style: TextStyle(
                                color: CustomColors.greyColor,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            getTimePassed(lastMessage?.createdAt),
                            style:
                                const TextStyle(color: CustomColors.greyColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      lastMessage?.content ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const Divider(
        color: CustomColors.lightShadeGreyColor,
      ),
    ],
  );
}
