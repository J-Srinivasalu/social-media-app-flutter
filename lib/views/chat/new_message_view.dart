import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'new_message_viewmodel.dart';

class NewMessageView extends StatelessWidget {
  const NewMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return ViewModelBuilder<NewMessageViewModel>.reactive(
      builder: (context, model, child) => LoadingOverlay(
        isLoading: model.isBusy,
        progressIndicator: const CircularProgressIndicator(),
        color: Colors.black,
        opacity: 0.2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("New Message"),
          ),
          body: Stack(
            children: [
              model.friends.isEmpty
                  ? const Center(
                      child: Text("No Friends Found"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 50),
                      itemCount: model.friends.length,
                      itemBuilder: (context, index) {
                        debugPrint("pic: ${model.friends[index].profilePic}");
                        return ListTile(
                          onTap: () => model.navigateToIndividualChat(
                              model.friends[index], chatProvider),
                          leading: Container(
                            height: 40,
                            width: 40,
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomColors.primaryColor),
                            child: CachedNetworkImage(
                              imageUrl: model.friends[index].profilePic ?? "",
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
                              progressIndicatorBuilder:
                                  (context, url, progress) {
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
                            model.friends[index].fullName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "@${model.friends[index].username}",
                            style: const TextStyle(
                                color: CustomColors.darkGreyColor),
                          ),
                        );
                      }),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: "Search",
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: CustomColors.greyColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          model.searchController.clear();
                        },
                        icon: const Icon(Icons.cancel),
                        color: CustomColors.backgroundGreyColor,
                      ),
                    ),
                    controller: model.searchController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => NewMessageViewModel(),
      onViewModelReady: (model) => model.initialize(profileProvider),
    );
  }
}
