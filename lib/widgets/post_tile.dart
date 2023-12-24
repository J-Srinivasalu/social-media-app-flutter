import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/helper_functions.dart';
import 'package:social_media_app/views/home/single_post_view.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final bool fromHome;
  const PostTile({super.key, required this.post, required this.fromHome});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    return ViewModelBuilder<PostTileViewModel>.reactive(
      builder: (context, model, child) => Column(
        children: [
          InkWell(
            onTap: () => model.navigateToSinglePost(post),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    splashColor: CustomColors.blueLightColor,
                    onTap: () {
                      if (fromHome) {
                        model.navigateToPublicProfile(post.user);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.primaryColor),
                      child: CachedNetworkImage(
                        imageUrl: post.user?.profilePic ?? "",
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              color: CustomColors.whiteColor,
                            ),
                          );
                        },
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                post.user?.fullName ?? "",
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
                                model.timePassed,
                                style: const TextStyle(
                                    color: CustomColors.greyColor),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          post.content ?? "",
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (post.medias.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: post.medias.length,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.all(2),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: post.medias[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => model.likePost(
                                    postProvider, post, profileProvider.id),
                                icon: Icon(
                                  !post.likes.contains(profileProvider.id)
                                      ? Icons.thumb_up_alt_outlined
                                      : Icons.thumb_up,
                                  color:
                                      !post.likes.contains(profileProvider.id)
                                          ? CustomColors.greyColor
                                          : CustomColors.primaryColor,
                                ),
                              ),
                              Text(post.likes.length.toString()),
                              const SizedBox(
                                width: 12,
                              ),
                              const Icon(
                                Icons.chat_outlined,
                                color: CustomColors.greyColor,
                              ),
                              Text(post.comments.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: CustomColors.lightShadeGreyColor,
          ),
        ],
      ),
      viewModelBuilder: () => PostTileViewModel(),
      onViewModelReady: (model) => model.initialize(post),
    );
  }
}

class PostTileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _toastService = locator<ToastService>();
  String timePassed = "0s";

  void initialize(Post post) {
    timePassed = getTimePassed(post.createdAt);
  }

  Future<void> likePost(
      PostProvider postProvider, Post post, String? userId) async {
    if (post.likes.contains(userId)) return;
    try {
      postProvider.likePost(post.id!, userId!);
      notifyListeners();
      await _apiService.likePost(post.id!);
    } catch (error) {
      debugPrint(error.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  void navigateToSinglePost(Post post) {
    _navigationService.navigateToView(SinglePostView(post: post));
  }

  void navigateToPublicProfile(User? user) {
    if (user == null) {
      _toastService
          .callToast("Something went wrong please retry after sometime");
      return;
    }
    _navigationService
        .navigateToView(PublicProfileView(userPublicProfile: user));
    debugPrint("pbulic profile");
  }
}
