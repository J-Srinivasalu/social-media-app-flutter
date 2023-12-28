import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'friend_reqeust_viewmodel.dart';

class FriendRequestView extends StatelessWidget {
  const FriendRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<FriendRequestViewModel>.reactive(
        builder: (context, model, child) => LoadingOverlay(
              isLoading: model.isBusy,
              progressIndicator: const CircularProgressIndicator(),
              color: Colors.black,
              opacity: 0.2,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Friend requests"),
                    bottom: const TabBar(
                        indicatorColor: CustomColors.primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: CustomColors.primaryColor,
                        tabs: [
                          Tab(text: "Received"),
                          Tab(text: "Sent"),
                        ]),
                  ),
                  body: TabBarView(
                    children: [
                      profileProvider.friendRequestReceived.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  profileProvider.friendRequestReceived.length,
                              itemBuilder: (context, index) =>
                                  _friendRequestTile(
                                user: profileProvider
                                    .friendRequestReceived[index].user,
                                status: null,
                                model: model,
                                profileProvider: profileProvider,
                              ),
                            )
                          : const Center(
                              child: Text("No friend request received"),
                            ),
                      profileProvider.friendRequestSent.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  profileProvider.friendRequestSent.length,
                              itemBuilder: (context, index) =>
                                  _friendRequestTile(
                                user: profileProvider
                                    .friendRequestSent[index].user,
                                status: profileProvider
                                        .friendRequestSent[index].status ??
                                    "UNAVAILABLE",
                                model: model,
                                profileProvider: profileProvider,
                              ),
                            )
                          : const Center(
                              child: Text("No friend request sent"),
                            ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => FriendRequestViewModel());
  }
}

Widget _friendRequestTile({
  required User? user,
  required String? status,
  required FriendRequestViewModel model,
  required ProfileProvider profileProvider,
}) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(
              left: 16,
              top: 16,
              bottom: 16,
              right: 8,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: user?.profilePic ?? "",
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    user?.fullName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "@${user?.username}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CustomColors.darkGreyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  status == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () => model.acceptFriendRequest(
                                    profileProvider,
                                    user,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () => model.rejectFriendRequest(
                                    profileProvider,
                                    user,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CustomColors.lightGreyColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(color: CustomColors.primaryColor),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: CustomColors.primaryColor),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      const Divider(
        color: CustomColors.lightShadeGreyColor,
      ),
    ],
  );
}
