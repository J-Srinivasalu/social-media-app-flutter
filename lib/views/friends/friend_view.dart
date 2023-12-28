import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'friend_viewmodel.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<FriendViewModel>.reactive(
        builder: (context, model, child) => LoadingOverlay(
              isLoading: model.isBusy,
              progressIndicator: const CircularProgressIndicator(),
              color: Colors.black,
              opacity: 0.2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Friends"),
                ),
                body: profileProvider.friends.isNotEmpty
                    ? ListView.builder(
                        itemCount: profileProvider.friends.length,
                        itemBuilder: (context, index) => _friendTile(
                          user: profileProvider.friends[index],
                          profileProvider: profileProvider,
                          model: model,
                        ),
                      )
                    : const Center(
                        child: Text("No Friends"),
                      ),
              ),
            ),
        viewModelBuilder: () => FriendViewModel());
  }
}

Widget _friendTile(
    {User? user,
    required FriendViewModel model,
    required ProfileProvider profileProvider}) {
  debugPrint("XYZ");
  debugPrint(user.toString());
  return Column(
    children: [
      InkWell(
        onTap: () => model.navigateToPublicProfile(user),
        child: Row(
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
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () => model.unfriendUser(
                        profileProvider,
                        user,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.pinkishredColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        "Unfriend",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const Divider(
        color: CustomColors.lightShadeGreyColor,
      ),
    ],
  );
}
