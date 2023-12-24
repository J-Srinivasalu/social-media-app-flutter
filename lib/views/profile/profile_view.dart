import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
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
                                profileProvider.username ?? "",
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
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () => askConfirmation(context, model),
                      leading: const Icon(
                        Icons.logout,
                        size: 20,
                      ),
                      title: const Text("Logout"),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  )
                ],
              ),
            ),
        viewModelBuilder: () => ProfileViewModel());
  }
}

askConfirmation(BuildContext context, ProfileViewModel model) async {
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
          model.logout();
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
