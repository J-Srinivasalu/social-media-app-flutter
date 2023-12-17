// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/helper_functions.dart';
import 'package:stacked/stacked.dart';

import 'single_post_viewmodel.dart';

class SinglePostView extends StatelessWidget {
  final Post post;
  const SinglePostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    return ViewModelBuilder<SinglePostViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Post"),
              ),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
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
                                imageUrl: post.user.profileImage ?? "",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                placeholder: (context, url) => const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      post.user.fullName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      post.user.username ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: CustomColors.darkGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            post.content,
                            maxLines: null,
                          ),
                        ),
                        if (post.media.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: post.media.length,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.all(2),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: post.media[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(
                                !post.likes.contains(profileProvider.username)
                                    ? Icons.thumb_up_alt_outlined
                                    : Icons.thumb_up,
                                color: !post.likes
                                        .contains(profileProvider.username)
                                    ? CustomColors.greyColor
                                    : CustomColors.primaryColor,
                              ),
                              Text(post.likes.length.toString()),
                              const SizedBox(
                                width: 12,
                              ),
                              const Icon(
                                Icons.chat_outlined,
                                color: CustomColors.greyColor,
                              ),
                              Text(post.comments.length.toString()),
                            ],
                          ),
                        ),
                        const Divider(
                          color: CustomColors.lightShadeGreyColor,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            "Comments : ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: post.comments.length,
                          itemBuilder: (context, index) => _commentTile(
                            model,
                            profileProvider,
                            post.comments[index],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: CustomColors.lightGreyColor,
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 10,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: TextFormField(
                                    controller: model.commentController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    minLines: 1,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.blackColor),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CustomColors.lightGreyColor),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CustomColors.lightGreyColor),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                      ),
                                      hintText: "what's in your mind...",
                                      hintStyle: TextStyle(
                                          color: CustomColors.lightGreyColor),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    model.uploadComment(post, profileProvider),
                                child: const Text(
                                  "Send",
                                  style: TextStyle(
                                      color: CustomColors.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        viewModelBuilder: () => SinglePostViewModel());
  }
}

Widget _commentTile(SinglePostViewModel model, ProfileProvider profileProvider,
    Comment comment) {
  return Container(
    margin: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          splashColor: CustomColors.blueLightColor,
          onTap: () {
            model.navigateToPublicProfile(comment.user);
          },
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CustomColors.primaryColor),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            comment.user.fullName,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const Text(
                            " · ",
                            style: TextStyle(
                                color: CustomColors.greyColor,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            getTimePassed(comment.createdAt),
                            style:
                                const TextStyle(color: CustomColors.greyColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      comment.content,
                      maxLines: null,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    visualDensity:
                        const VisualDensity(horizontal: -3, vertical: -3),
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        model.likeComment(comment, profileProvider.username),
                    icon: Icon(
                      !comment.likes.contains(profileProvider.username)
                          ? Icons.thumb_up_alt_outlined
                          : Icons.thumb_up,
                      color: !comment.likes.contains(profileProvider.username)
                          ? CustomColors.greyColor
                          : CustomColors.primaryColor,
                      size: 16,
                    ),
                  ),
                  Text(comment.likes.length.toString()),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
