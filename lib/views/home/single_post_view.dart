// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/utils/custom_colors.dart';
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
    return ViewModelBuilder<SinglePostViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Post"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            errorWidget: (context, url, error) => const Icon(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => SinglePostViewModel());
  }
}
