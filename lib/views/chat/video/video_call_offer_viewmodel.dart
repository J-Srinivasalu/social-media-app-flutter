import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/socket_io_service.dart';
import 'package:social_media_app/utils/socket_events.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VideoCallOfferViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _socketIOService = locator<SocketIOService>();
  final _apiService = locator<ApiService>();
  final localVideoRenderer = RTCVideoRenderer();
  MediaStream? stream;
  void initialize(User friend, String chatId, String offer, String messageId,
      bool offerAccepted) async {
    try {
      await localVideoRenderer.initialize();
      await _getUserMedia();
      if (offerAccepted) {
        acceptOffer(friend, chatId, offer, messageId);
      }

      _socketIOService.socket?.on(
        ChatEventEnum.VIDEO_CALL_MISSED_EVENT,
        (data) {
          try {
            debugPrint(
                "IndividualChatViewModel: ChatEventEnum.VIDEO_CALL_MISSED_EVENT : $data");
            _navigationService.back();
          } catch (error, es) {
            debugPrint(
                "IndividualChatViewModel: ChatEventEnum.VIDEO_CALL_MISSED_EVENT ERROR");
            debugPrint(error.toString());
            debugPrint(es.toString());
          }
        },
      );
    } catch (error, es) {
      debugPrint("VideoCallOfferViewModel: initialize - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  _getUserMedia() async {
    try {
      final Map<String, dynamic> mediaConstraints = {
        'audio': true,
        'video': {
          'facingMode': 'user',
        }
      };

      stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

      debugPrint(
          "VideoCallOfferViewModel: _getUserMedia - stream: ${stream?.id}");

      localVideoRenderer.srcObject = stream;
      notifyListeners();
    } catch (error, es) {
      debugPrint("VideoCallOfferViewModel: _getUserMedia - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  void acceptOffer(
      User user, String chatId, String offer, String messageId) async {
    await onDispose();
    _navigationService.replaceWithVideoCallViewRoute(
        user: user, chatId: chatId, offer: offer, messageId: messageId);
  }

  void rejectOffer(String receiverId, String messageId) async {
    await _apiService.rejectVideoCallRequest(receiverId, messageId);
    await onDispose();
    _navigationService.back();
  }

  Future<void> onDispose() async {
    debugPrint("VideoCallOfferViewModel: onDispose");
    try {
      await stream?.dispose();
      await localVideoRenderer.dispose();
    } catch (error, es) {
      debugPrint("VideoCallOfferViewModel: onDispose - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }
}
