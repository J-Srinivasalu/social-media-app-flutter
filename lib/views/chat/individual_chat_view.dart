// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/helper_functions.dart';
import 'package:social_media_app/widgets/connection_aware_widget.dart';
import 'package:stacked/stacked.dart';

import 'individual_chat_viewmodel.dart';

class IndividualChatView extends StatelessWidget {
  final User friend;
  final String chatId;
  const IndividualChatView({
    Key? key,
    required this.friend,
    required this.chatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return ViewModelBuilder<IndividualChatViewModel>.reactive(
      builder: (context, model, child) => ConnectionAwareWidget(
        child: LoadingOverlay(
          isLoading: model.isBusy,
          progressIndicator: const CircularProgressIndicator(),
          color: Colors.black,
          opacity: 0.2,
          child: Scaffold(
            appBar: AppBar(
              title: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: CustomColors.primaryColor),
                  child: CachedNetworkImage(
                    imageUrl: friend.profilePic ?? "",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      debugPrint(error.toString());
                      debugPrint(url.toString());
                      return const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: CustomColors.whiteColor,
                        ),
                      );
                    },
                  ),
                ),
                title: Text(
                  friend.fullName ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  model.isTyping
                      ? "typing..."
                      : friend.isOnline
                          ? "Online"
                          : getTimePassed(friend.updatedAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: CustomColors.blueColor,
                  ),
                ),
              ),
            ),
            body: Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      controller: model.messageRefreshController,
                      scrollController: model.messagesScrollController,
                      onRefresh: () async {
                        if (!model.isLoading) {
                          await model.fetchMessages(chatId);
                        }
                      },
                      child: ListView.builder(
                        itemCount: model.messages.length,
                        itemBuilder: (context, index) =>
                            _message(profileProvider, model, index),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: CustomColors.lightGreyColor,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 10,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 8,
                              ),
                              child: TextFormField(
                                controller: model.messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                minLines: 1,
                                onTap: () {
                                  model.moveToLast();
                                },
                                onEditingComplete: () =>
                                    debugPrint("keyboard came down"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.blackColor),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomColors.lightGreyColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomColors.lightGreyColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                  ),
                                  hintText: "what's in your mind...",
                                  hintStyle: TextStyle(
                                      color: CustomColors.lightGreyColor),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => model.sendMessage(
                              friend,
                              chatId,
                              chatProvider,
                              profileProvider,
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
      viewModelBuilder: () => IndividualChatViewModel(),
      onViewModelReady: (model) =>
          model.initialize(profileProvider, chatProvider, chatId),
      onDispose: (model) => model.clearEverything(chatProvider),
    );
  }
}

_message(
    ProfileProvider profileProvider, IndividualChatViewModel model, int index) {
  bool isFromCurrentUser =
      model.messages[index].sender?.id == profileProvider.id;
  return isFromCurrentUser
      ? messageByUser(model, index)
      : messageByOthers(model, index);
}

Widget messageByOthers(IndividualChatViewModel model, int index) {
  return Padding(
    padding: const EdgeInsets.only(right: 100, left: 16, bottom: 44),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: CustomColors.blueDarkestColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Text(
            model.messages[index].content ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        Text(
          getTimePassed(model.messages[index].createdAt),
          textAlign: TextAlign.left,
          style: const TextStyle(color: CustomColors.greyColor),
        ),
      ],
    ),
  );
}

Widget messageByUser(IndividualChatViewModel model, int index) {
  var status = model.messages[index].status;
  return Container(
    padding: const EdgeInsets.only(left: 100, right: 16, bottom: 44),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Text(
            model.messages[index].content ?? "",
            style: const TextStyle(
                color: CustomColors.darkGreyColor, fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              getTimePassed(model.messages[index].createdAt),
              style: const TextStyle(color: CustomColors.greyColor),
            ),
            Text(
              status != null ? " · $status" : "",
              style: const TextStyle(color: CustomColors.greyColor),
            ),
          ],
        ),
      ],
    ),
  );
}
