// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'video_call_viewmodel.dart';

class VideoCallView extends StatelessWidget {
  final User user;
  final String chatId;
  final String? offer;
  final String? messageId;
  const VideoCallView(
      {Key? key,
      required this.user,
      required this.chatId,
      this.offer,
      this.messageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return ViewModelBuilder<VideoCallViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: RTCVideoView(
                model.callStartedAt == null
                    ? model.localVideoRenderer
                    : model.remoteVideoRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),
            if (model.callStartedAt != null)
              Positioned(
                top: 70.0,
                right: 16.0,
                child: Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: RTCVideoView(
                    model.localVideoRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            Positioned(
              bottom: 40.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (model.callStartedAt != null)
                    InkWell(
                      onTap: () {
                        model.switchCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.primaryColor),
                        child: const Icon(
                          Icons.switch_camera_sharp,
                          color: CustomColors.whiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                  if (model.callStartedAt != null)
                    InkWell(
                      onTap: () {
                        model.toggleVideoFeed();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: model.isCameraMute
                                ? CustomColors.pinkishredColor
                                : CustomColors.primaryColor),
                        child: Icon(
                          model.isCameraMute
                              ? Icons.videocam_off
                              : Icons.videocam,
                          color: CustomColors.whiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                  if (model.callStartedAt != null)
                    InkWell(
                      onTap: () {
                        model.toggleAudio();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: model.isAudioMute
                                ? CustomColors.pinkishredColor
                                : CustomColors.primaryColor),
                        child: Icon(
                          model.isAudioMute ? Icons.mic_off : Icons.mic,
                          color: CustomColors.whiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      model.endCall(chatId, messageId, user.id);
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
      viewModelBuilder: () => VideoCallViewModel(),
      onViewModelReady: (model) =>
          model.initialize(profileProvider, chatProvider, chatId, offer, user),
    );
  }
}
