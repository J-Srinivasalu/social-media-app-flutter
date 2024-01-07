import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 16,
                      bottom: 24,
                      right: 16,
                      left: 16,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.primaryColor),
                          child: CachedNetworkImage(
                            imageUrl: profileProvider.profilePic ?? "",
                            width: 75,
                            height: 75,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: CustomColors.whiteColor,
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                profileProvider.fullName ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "@${profileProvider.username}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.darkGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => model.navigateToEditProfile(),
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: CustomColors.primaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  profileOptions(
                    onClick: () => model.navigateToFriendView(),
                    text: "Friends",
                    icon: Icons.people_alt,
                  ),
                  profileOptions(
                    onClick: () => model.navigateToFriendRequestView(),
                    text: "Friend Requests",
                    icon: Icons.person_add_alt_sharp,
                  ),
                  profileOptions(
                    onClick: () => askConfirmation(
                      context,
                      model,
                      profileProvider,
                      postProvider,
                      chatProvider,
                    ),
                    text: "Logout",
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => ProfileViewModel());
  }
}

Widget profileOptions(
    {required Function onClick, required String text, required IconData icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: CustomColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      onTap: () => onClick(),
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    ),
  );
}

askConfirmation(
  BuildContext context,
  ProfileViewModel model,
  ProfileProvider profileProvider,
  PostProvider postProvider,
  ChatProvider chatProvider,
) async {
  Widget negativeButton(ctx) => TextButton(
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "No",
          ),
        ),
        onPressed: () {
          Navigator.pop(ctx, false);
        },
      );
  Widget positiveButton(ctx) => TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(CustomColors.blueDarkestColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.pop(ctx, false);
          model.logout(
            profileProvider,
            postProvider,
            chatProvider,
          );
        },
      );

  AlertDialog alert(ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        content: Container(
          padding: const EdgeInsets.only(top: 8),
          child: const Text(
            "Do you want to Logout?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          negativeButton(ctx),
          positiveButton(ctx),
        ],
      );

  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return alert(ctx);
    },
  );
}
