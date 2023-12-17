// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/widgets/post_tile.dart';
import 'package:stacked/stacked.dart';

import 'public_profile_viewmodel.dart';

class PublicProfileView extends StatelessWidget {
  final User userPublicProfile;
  const PublicProfileView({
    Key? key,
    required this.userPublicProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PublicProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
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
                    child: model.user.profileImage != null
                        ? CachedNetworkImage(
                            imageUrl: model.user.profileImage!,
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
                          model.user.fullName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          model.user.username!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: CustomColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8, top: 6),
              child: const Text(
                "Posts",
                style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const Divider(
              height: 2,
              color: CustomColors.primaryColor,
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostTile(
                  post: model.posts[index],
                  fromHome: false,
                ),
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => PublicProfileViewModel(),
      onViewModelReady: (model) => model.initialize(userPublicProfile),
    );
  }
}
