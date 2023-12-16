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
    final _profileProvider = Provider.of<ProfileProvider>(context);
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
                          child: _profileProvider.profileImage != null
                              ? CachedNetworkImage(
                                  imageUrl: _profileProvider.profileImage!,
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                )
                              : IconButton(
                                  onPressed: () => {},
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _profileProvider.fullName!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                _profileProvider.username!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.darkGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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
                      onTap: () => model.logout(),
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
