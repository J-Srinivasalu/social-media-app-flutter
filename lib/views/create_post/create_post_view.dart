import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/widgets/upload_image_from.dart';
import 'package:stacked/stacked.dart';

import 'create_post_viewmodel.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ViewModelBuilder<CreatePostViewModel>.reactive(
        builder: (context, model, child) => LoadingOverlay(
              isLoading: model.isBusy,
              progressIndicator: const CircularProgressIndicator(),
              color: Colors.black,
              opacity: 0.2,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      model.navigateBack();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: CustomColors.greyColor,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () =>
                          model.uploadPost(postProvider, profileProvider),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: model.postContentController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "What's happening..."),
                        ),
                      ),
                      if (model.attachments.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 42),
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.attachments.length,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(
                                          model.attachments[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -12,
                                    right: -16,
                                    child: InkWell(
                                      onTap: () {
                                        model.removeAttachment(index);
                                      },
                                      child: const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: CustomColors.greyColor,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (_, __) {
                              return const SizedBox(
                                width: 32,
                              );
                            },
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              showUploadAttachment(context, model);
                            },
                            icon: const Icon(
                              Icons.image,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // showSelectVisibleToModelSheet(context, model);
                            },
                            child: Text(
                              model.visibleTo,
                              style: const TextStyle(
                                  color: CustomColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => CreatePostViewModel());
  }
}

showSelectVisibleToModelSheet(BuildContext context, CreatePostViewModel model) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  "Select Who can see this",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  model.setVisibleTo(0);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColors.lightBlueColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Everyone"),
                ),
              ),
              InkWell(
                onTap: () {
                  model.setVisibleTo(1);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColors.lightBlueColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text("Only Friends"),
                ),
              ),
            ],
          ),
        );
      });
}

Future showUploadAttachment(context, CreatePostViewModel model) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: UploadImageFrom(
          title: "Attach images",
          actionWithImage: (file) {
            model.addAttachment(file);
          },
        ),
      );
    },
  );
}
