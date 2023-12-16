import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/widgets/text_input_field.dart';
import 'package:stacked/stacked.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          actions: [
            InkWell(
              onTap: () => model.updateProfile(profileProvider),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                child: const Text(
                  "Save",
                  style: TextStyle(color: CustomColors.primaryColor),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 160,
                  height: 160,
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: profileProvider.profileImage ?? "",
                    errorWidget: (context, url, error) => const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    placeholder: (context, error) => const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextInputField(
                controller: model.nameController,
                keyboardType: TextInputType.emailAddress,
                text: "Name",
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EditProfileViewModel(),
    );
  }
}
