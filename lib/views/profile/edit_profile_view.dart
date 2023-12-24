import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/widgets/text_input_field.dart';
import 'package:social_media_app/widgets/upload_image_from.dart';
import 'package:stacked/stacked.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => LoadingOverlay(
        isLoading: model.isBusy,
        progressIndicator: const CircularProgressIndicator(),
        color: Colors.black,
        opacity: 0.2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            actions: [
              InkWell(
                onTap: () => model.updateProfile(profileProvider),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: (profileProvider.fullName !=
                                    model.nameController.text ||
                                model.newProfilePic.isNotEmpty)
                            ? CustomColors.primaryColor
                            : CustomColors.greyColor),
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
                  onTap: () {
                    showImagePicker(context, model);
                  },
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
                    child: model.newProfilePic.isEmpty
                        ? CachedNetworkImage(
                            imageUrl: profileProvider.profilePic ?? "",
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 100,
                            ),
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: CustomColors.whiteColor,
                                ),
                              );
                            },
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(model.newProfilePic),
                            width: 160,
                            height: 160,
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
      ),
      viewModelBuilder: () => EditProfileViewModel(),
      onViewModelReady: (model) => model.initialize(profileProvider),
    );
  }
}

Future showImagePicker(context, EditProfileViewModel model) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: UploadImageFrom(
          title: "Attach image",
          actionWithImage: (file) {
            model.updateProfilePic(file);
          },
        ),
      );
    },
  );
}
