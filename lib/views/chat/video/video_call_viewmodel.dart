import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/socket_io_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/socket_events.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VideoCallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _socketIOService = locator<SocketIOService>();
  final _toastService = locator<ToastService>();
  final localVideoRenderer = RTCVideoRenderer();
  final remoteVideoRenderer = RTCVideoRenderer();

  bool _offer = false;
  bool connectionClosed = false;

  bool _isCameraMute = true;

  bool get isCameraMute => _isCameraMute;

  bool _isAudioMute = true;

  bool get isAudioMute => _isAudioMute;

  String _currentFacingMode = "user";

  Timer? timer;

  DateTime? callStartedAt;
  ChatMessage? message;

  String duration = "";

  RTCPeerConnection? _peerConnection;
  RTCPeerConnection? get peerConnection => _peerConnection;

  MediaStream? _localStream;

  void initialize(ProfileProvider profileProvider, ChatProvider chatProvider,
      String chatId, String? offer, User friend) async {
    try {
      //initilize video renderers for local and remote users feed
      await localVideoRenderer.initialize();
      await remoteVideoRenderer.initialize();

      //create peer connection
      _peerConnection =
          await runBusyFuture(_createPeerConnecion(chatId, friend.id));

      // if offer is null user is try to send a video call request.
      if (offer == null) {
        final usersOffer = await runBusyFuture(_createOffer());
        debugPrint(
            "VideoCallViewModel: initialize - ${profileProvider.fullName} created offer: $usersOffer");
        await runBusyFuture(
          sendVideoCallRequest(
            profileProvider,
            chatProvider,
            chatId,
            usersOffer,
            friend,
          ),
        );
        // lisener to track, when receiver accept the offer
        _socketIOService.socket?.on(ChatEventEnum.VIDEO_CALL_ACCEPT_EVENT,
            (answer) async {
          debugPrint(
              "VideoCallViewModel: initialize - Offer accepted, with answer: $answer");
          await _setRemoteDescription(offer: answer);
        });
      }
      //else user is accepting a video call request
      else {
        if (friend.id == null || friend.id?.isEmpty == true) {
          debugPrint("VideoCallViewModel: initialize - USER NOT FOUND");
        }
        await runBusyFuture(
          _setRemoteDescription(
            userId: friend.id,
            offer: offer,
            chatId: chatId,
          ),
        );
      }

      _socketIOService.socket?.on(ChatEventEnum.VIDEO_CALL_ADD_CONDIDATE_EVENT,
          (candidate) async {
        debugPrint("VideoCallViewModel: initialize - candidate : $candidate");
        await _addCandidate(candidate);
      });

      _socketIOService.socket?.on(ChatEventEnum.VIDEO_CALL_REJECT_EVENT,
          (data) {
        debugPrint("VideocallViewModel; initialize - call rejected");
        debugPrint(
            "VideoCallViewModel: initialize - call rejected : ${data.toString()}");
        if (!connectionClosed) {
          connectionClosed = true;
        }
        final ChatMessage chatMessage = ChatMessage.fromMap(data["message"]);
        chatMessage.content = "Video call: Declined";
        debugPrint(
            "VideoCallViewModel: initialize - call rejected chat: ${chatMessage.toMap()}");

        onDispose();
        debugPrint(
            "VideoCallViewModel: initialize - disposed : ${message.toString()}");
        _navigationService.back(result: chatMessage);
      });

      _socketIOService.socket?.on(ChatEventEnum.VIDEO_CALL_ENDED_EVENT, (data) {
        debugPrint(data.toString());
        if (peerConnection?.iceConnectionState !=
                RTCIceConnectionState.RTCIceConnectionStateClosed ||
            peerConnection?.iceConnectionState !=
                RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
            peerConnection?.iceConnectionState !=
                RTCIceConnectionState.RTCIceConnectionStateFailed) {
          peerConnection?.close();
        }

        debugPrint("VideoCallViewModel: initialize - on ended");
        message?.content = "Video call: $duration";
        debugPrint("VideoCallViewModel: initialize - on ended: $duration");
        if (message != null) {
          debugPrint(
              "VideoCallViewModel: initialize - on ended updated last message");
          chatProvider.updateLastMessage(message!);
        }
        if (!connectionClosed) {
          debugPrint(
              "VideoCallViewModel: initialize - on ended : connection check passed");
          connectionClosed = true;
          duration = formatTimeDifference();
          message?.content = "Video call: $duration";
          onDispose();
          _navigationService.back(result: message);
        }
      });
    } catch (error, es) {
      debugPrint("VideoCallViewModel: initialize - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService.callToast("Initialization failed, check logs");
    }
  }

  sendVideoCallRequest(
    ProfileProvider profileProvider,
    ChatProvider chatProvider,
    String chatId,
    String offer,
    User friend,
  ) async {
    notifyListeners();
    //todo: add callback to individual message to add video call to _messages
    try {
      final response = await _apiService.sendVideoCallRequest(chatId, offer);
      if (response.isSuccessful()) {
        ChatMessage? newMessage = ChatMessage.fromMap(
            response.responseGeneral.detail?.data["message"]);
        //todo: update message id and status
        message = newMessage;
        debugPrint(
            "VideoCallViewModel: sendVideoCallRequest - message:$newMessage");
        timer = Timer(const Duration(minutes: 1), () {
          _socketIOService.socket?.emit(ChatEventEnum.VIDEO_CALL_MISSED_EVENT, {
            "messageId": newMessage.id,
          });
          onDispose();
          connectionClosed = true;
          message?.content = "Video call: Missed";
          _navigationService.back(result: message);
        });
        chatProvider.updateLastMessage(newMessage);
        notifyListeners();
      }
    } catch (error, es) {
      debugPrint("VideoCallViewModel: sendVideoCallRequest - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
      _toastService
          .callToast("Something went wrong, Please try after sometime");
    }
  }

  _setUserMedia() async {
    try {
      final Map<String, dynamic> mediaConstraints = {
        'audio': true,
        'video': {
          'facingMode': _currentFacingMode,
        }
      };

      MediaStream stream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);

      debugPrint("VideoCallViewModel: _getUserMedia - Stream: $stream");

      localVideoRenderer.srcObject = stream;
      notifyListeners();
      return stream;
    } catch (error, es) {
      debugPrint("VideoCallViewModel: _getUserMedia - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  Future<RTCPeerConnection?> _createPeerConnecion(
      String chatId, String? userId) async {
    try {
      Map<String, dynamic> configuration = {
        "iceServers": [
          {"url": "stun:stun.l.google.com:19302"},
        ]
      };

      final Map<String, dynamic> offerSdpConstraints = {
        "mandatory": {
          "OfferToReceiveAudio": true,
          "OfferToReceiveVideo": true,
        },
        "optional": [],
      };

      _localStream = await _setUserMedia();

      RTCPeerConnection pc =
          await createPeerConnection(configuration, offerSdpConstraints);

      debugPrint("VideoCallViewModel: _createPeerConnecion - pc: $pc");
      _localStream!.getTracks().forEach((track) async {
        await pc.addTrack(track, _localStream!);
      });

      pc.onIceCandidate = (e) {
        debugPrint(
            "VideoCallViewModel: _createPeerConnecion - onIceCandidate: ${e.toMap().toString()}");
        if (e.candidate != null) {
          debugPrint("""VideoCallViewModel: _createPeerConnecion
                ${json.encode({
                'candidate': e.candidate.toString(),
                'sdpMid': e.sdpMid.toString(),
                'sdpMlineIndex': e.sdpMLineIndex,
              })}""");
          debugPrint(
              "VideoCallViewModel: _createPeerConnecion - userId: $userId, chatId: $chatId");
          _socketIOService.socket
              ?.emit(ChatEventEnum.VIDEO_CALL_ADD_CONDIDATE_EVENT, {
            "receiverId": userId ?? "",
            "chatId": chatId,
            "candidate": json.encode({
              'candidate': e.candidate.toString(),
              'sdpMid': e.sdpMid.toString(),
              'sdpMlineIndex': e.sdpMLineIndex,
            }),
          });
          notifyListeners();
        }
      };

      pc.onIceConnectionState = (e) {
        debugPrint(
            "VideoCallViewModel: _createPeerConnecion - onIceConnectionState e: ${e.toString()}");
        if (pc.iceConnectionState ==
                RTCIceConnectionState.RTCIceConnectionStateConnected ||
            pc.iceConnectionState ==
                RTCIceConnectionState.RTCIceConnectionStateCompleted) {
          debugPrint(
              "VideoCallViewModel: _createPeerConnecion - onIceConnectionState: ${pc.iceConnectionState}");

          debugPrint(
              "VideoCallViewModel: _createPeerConnecion - isTimerActive: ${timer?.isActive}");
          timer?.cancel();
          callStartedAt = DateTime.now();
          debugPrint(
              "VideoCallViewModel: _createPeerConnecion - onIceConnectionState: ${callStartedAt?.toIso8601String()}");
          notifyListeners();
        }

        if (pc.iceConnectionState ==
                RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
            pc.iceConnectionState ==
                RTCIceConnectionState.RTCIceConnectionStateClosed ||
            pc.iceConnectionState ==
                RTCIceConnectionState.RTCIceConnectionStateFailed) {
          debugPrint(
              "VideoCallViewModel: _createPeerConnecion - connection closed");
          if (!connectionClosed) {
            connectionClosed = true;
            duration = formatTimeDifference();
            message?.content = "Video call: $duration";
            onDispose();
            _navigationService.back(result: message);
          }
        }
      };

      pc.onAddStream = (stream) {
        debugPrint(
            "VideoCallViewModel: _createPeerConnecion - onAddStream id: ${stream.id}");
        remoteVideoRenderer.srcObject = stream;
        notifyListeners();
      };

      return pc;
    } catch (error, es) {
      debugPrint("VideoCallViewModel: _createPeerConnecion - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
      return null;
    }
  }

  Future<String> _createOffer() async {
    RTCSessionDescription description =
        await _peerConnection!.createOffer({'offerToReceiveVideo': 1});
    debugPrint("VideoCallViewModel: _createOffer - description: $description");
    var session = parse(description.sdp.toString());
    var usersOffer = json.encode(session);
    _offer = true;
    await _peerConnection!.setLocalDescription(description);
    notifyListeners();
    return usersOffer;
  }

  Future<String> _createAnswer() async {
    RTCSessionDescription description =
        await _peerConnection!.createAnswer({'offerToReceiveVideo': 1});
    debugPrint("VideoCallViewModel: _createAnswer - description: $description");
    var session = parse(description.sdp.toString());
    var answer = json.encode(session);
    debugPrint("VideoCallViewModel: _createAnswer - Offer: $answer");

    await _peerConnection!.setLocalDescription(description);
    return answer;
  }

  Future<void> _setRemoteDescription({
    String? userId,
    required String offer,
    String? chatId,
  }) async {
    try {
      debugPrint("VideoCallViewModel: _setRemoteDescription - offer: $offer");
      String jsonString = offer;
      dynamic session = await jsonDecode(jsonString);

      String sdp = write(session, null);

      RTCSessionDescription description =
          RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
      debugPrint(
          "VideoCallViewModel: _setRemoteDescription - description: $description");

      await _peerConnection!.setRemoteDescription(description);
      debugPrint("VideoCallViewModel: _setRemoteDescription - offer accepted");
      if (chatId != null) {
        debugPrint("VideoCallViewModel: _setRemoteDescription - answer sent");
        final answer = await runBusyFuture(_createAnswer());
        _socketIOService.socket?.emit(ChatEventEnum.VIDEO_CALL_ACCEPT_EVENT, {
          "senderId": userId,
          "answer": answer,
        });
      }
    } catch (error, es) {
      debugPrint("VideoCallViewModel: _setRemoteDescription - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  Future<void> _addCandidate(String sdpString) async {
    try {
      debugPrint("VideoCallViewModel: _addCandidate - sdpString: $sdpString");
      dynamic session = await jsonDecode(sdpString);
      RTCIceCandidate candidate = RTCIceCandidate(
          session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
      await _peerConnection!.addCandidate(candidate);
      debugPrint("VideoCallViewModel: _addCandidate - candidate added");
    } catch (error, es) {
      debugPrint("VideoCallViewModel: _addCandidate - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  void endCall(String chatId, String? messageId, String? userId) async {
    debugPrint("VideoCallViewModel: endCall - chatId: $chatId");
    duration = formatTimeDifference();
    message?.content = "Video call: $duration";
    bool callAttended = callStartedAt != null;
    _socketIOService.socket?.emit(ChatEventEnum.VIDEO_CALL_ENDED_EVENT, {
      "chatId": chatId,
      "messageId": message?.id ?? messageId,
      "duration": duration,
      "attended": callAttended
    });
    onDispose();
    connectionClosed = true;
    if (!callAttended) {
      message?.content = "Video call: Missed";
    }
    _navigationService.back(result: message);
  }

  String formatTimeDifference() {
    if (callStartedAt == null) return "0s";
    Duration difference = DateTime.now().difference(callStartedAt!);

    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    String result = '';

    if (hours > 0) {
      result += '$hours${hours == 1 ? 'h' : 'h'} ';
    }

    if (minutes > 0 || hours > 0) {
      result += '$minutes${minutes == 1 ? 'm' : 'm'} ';
    }

    result += '$seconds${seconds == 1 ? 's' : 's'}';

    return result.trim();
  }

  void onDispose() async {
    try {
      debugPrint("VideoCallViewModel: onDispose");
      debugPrint(
          "VideoCallViewModel: onDispose - message: ${message?.toMap().toString()}");
      timer?.cancel();
      await peerConnection?.close();
      await _localStream?.dispose();
      await localVideoRenderer.dispose();
      await remoteVideoRenderer.dispose();
    } catch (error, es) {
      debugPrint("VideoCallViewModel: onDispose - ERROR");
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  void switchCamera() async {
    try {
      _currentFacingMode =
          (_currentFacingMode == 'user') ? 'environment' : 'user';
      await _localStream?.dispose();

      _localStream = await _setUserMedia();

      (await _peerConnection?.getSenders())?.forEach((sender) {
        if (sender.track?.kind == "video") {
          _localStream?.getVideoTracks().forEach((videoTrack) {
            sender.replaceTrack(videoTrack);
          });
        }
      });

      notifyListeners();
    } catch (error, es) {
      debugPrint(error.toString());
      debugPrint(es.toString());
    }
  }

  void toggleVideoFeed() {
    _isCameraMute = !_isCameraMute;
    _localStream!.getVideoTracks().forEach((track) {
      track.enabled = !track.enabled;
    });
    notifyListeners();
  }

  void toggleAudio() {
    _isAudioMute = !_isAudioMute;
    _localStream!.getAudioTracks().forEach((track) {
      track.enabled = !track.enabled;
    });
    notifyListeners();
  }
}
