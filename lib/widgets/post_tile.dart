import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostTileViewModel>.reactive(
      builder: (context, model, child) => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: CustomColors.primaryColor),
                  child: IconButton(
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              post.user.fullName,
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
                        post.content,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
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
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              color: CustomColors.greyColor,
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
                      )
                    ],
                  ),
                )
              ],
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
  String timePassed = "0s";

  void initialize(Post post) {
    debugPrint("user: ${post.user.fullName}");
    debugPrint("created: ${post.createdAt}");
    timePassed = getTimePassed(post.createdAt);
  }

  String getTimePassed(DateTime? dateTime) {
    if (dateTime == null) return "0s";
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 6) {
      return '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(dateTime.month)}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return '0s';
    }
  }

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[month - 1];
  }
}
