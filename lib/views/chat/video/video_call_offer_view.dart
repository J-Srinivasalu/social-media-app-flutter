// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'video_call_offer_viewmodel.dart';

class VideoCallOfferView extends StatelessWidget {
  final User friend;
  final String chatId;
  final String messageId;
  final String receiverId;
  final String offer;
  final bool offerAccepted;
  const VideoCallOfferView({
    Key? key,
    required this.friend,
    required this.chatId,
    required this.messageId,
    required this.offer,
    this.offerAccepted = false,
    required this.receiverId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoCallOfferViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: RTCVideoView(
                model.localVideoRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.primaryColor),
                    child: CachedNetworkImage(
                      imageUrl: friend.profilePic ?? "",
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        debugPrint(error.toString());
                        debugPrint(url.toString());
                        return const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 140,
                        );
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: CustomColors.whiteColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      friend.fullName ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      model.acceptOffer(friend, chatId, offer, messageId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.primaryColor),
                      child: const Icon(
                        Icons.call,
                        color: CustomColors.whiteColor,
                        size: 40,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      model.rejectOffer(receiverId, messageId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.pinkishredColor),
                      child: const Icon(
                        Icons.call_end,
                        color: CustomColors.whiteColor,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => VideoCallOfferViewModel(),
      onViewModelReady: (model) =>
          model.initialize(friend, chatId, offer, messageId, offerAccepted),
    );
  }
}
