import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/chat.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/views/chat/video/video_call_offer_view.dart';
import 'package:stacked_services/stacked_services.dart';

// setup for notifications
final _apiService = locator<ApiService>();
final _navigationService = locator<NavigationService>();
final _toastService = locator<ToastService>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  "sma_channel",
  "sma notifications",
  description: 'This channel is for sma notifications',
  importance: Importance.max,
);
final AndroidNotificationChannel androidCallChannel =
    AndroidNotificationChannel(
  "sma_call_channel",
  "sma call notifications",
  description: 'This channel is for sma call notifications',
  importance: Importance.max,
  enableVibration: true,
  vibrationPattern: Int64List.fromList([0, 4000, 4000, 4000]),
  sound: const RawResourceAndroidNotificationSound("ringtone"),
  playSound: true,
);

Future<void> initNotifications() async {
  var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings());

  final launchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (launchDetails?.didNotificationLaunchApp == true) {
    debugPrint("SMA: didNotificationLaunchApp onSelectNotification");
    onSelectNotification(launchDetails!.notificationResponse!);
  }

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification);

  final platform =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(androidChannel);
}

@pragma('vm:entry-point')
Future onSelectNotification(NotificationResponse notificationResponse) async {
  String? payload = notificationResponse.payload;
  debugPrint("onSelectNotification start");
  if (payload == null) {
    debugPrint("SMA: onSelectNotification no payload");
    return;
  }
  final data = jsonDecode(payload);
  if (data["isCall"] != null) return;
  debugPrint("SMA: onSelectNotification payload: $data");
  final chatMessage = ChatMessage.fromMap(data["message"] ?? data);
  final receiverId = chatMessage.receiver?.id;
  final sender = chatMessage.sender;
  final chatId = chatMessage.chat;
  final offer = chatMessage.offer;
  bool callAccepted = notificationResponse.actionId == "accept";

  cancelNotification(notificationResponse.id);

  if (receiverId == null || sender == null || chatId == null || offer == null) {
    debugPrint(
        "receiver id: $receiverId, chatId: $chatId, sender: ${sender?.toMap().toString()}, offer: $offer");
    _toastService.callToast("incomplete video call request can't be completed");
    return;
  }

  if (notificationResponse.actionId == "reject") {
    debugPrint("FirebaseService: onSelectNotification - call rejected");
    _apiService.rejectVideoCallRequest(receiverId, chatMessage.id ?? "");
  } else {
    _navigationService.navigateToView(
      VideoCallOfferView(
        friend: sender,
        chatId: chatId,
        receiverId: receiverId,
        messageId: chatMessage.id ?? "",
        offer: offer,
        offerAccepted: callAccepted,
      ),
    );
  }

  // _navigationService.navigateToView(const BottomNavbarView(viewIndex: 1));
}

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // handle action
// }

void createNotification(
  int id,
  String title,
  String body,
  bool forCall,
  dynamic data,
) async {
  try {
    debugPrint("createNotification: $data");
    debugPrint("DATA type: ${data.runtimeType}");

    AndroidNotificationDetails androidDetails = forCall
        ? AndroidNotificationDetails(
            androidCallChannel.id, androidCallChannel.name,
            channelDescription: androidCallChannel.description,
            importance: Importance.max,
            priority: Priority.max,
            autoCancel: false,
            ongoing: true,
            category: AndroidNotificationCategory.call,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            enableVibration: true,
            vibrationPattern: Int64List.fromList([0, 4000, 4000, 4000]),
            playSound: true,
            sound: const RawResourceAndroidNotificationSound("ringtone"),
            fullScreenIntent: true,
            actions: const [
                AndroidNotificationAction(
                  "accept",
                  "Accept",
                  titleColor: CustomColors.primaryColor,
                  showsUserInterface: true,
                  icon: DrawableResourceAndroidBitmap("videocam"),
                ),
                AndroidNotificationAction(
                  "reject",
                  "Reject",
                  titleColor: Colors.red,
                  showsUserInterface: true,
                  icon: DrawableResourceAndroidBitmap("reject"),
                ),
              ])
        : AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            importance: Importance.max,
            priority: Priority.max,
          );

    DarwinNotificationDetails darwinDetails = const DarwinNotificationDetails();

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
      ),
      payload: jsonEncode(data),
    );
  } catch (error, es) {
    debugPrint("Notification Service: create notification");
    debugPrint(error.toString());
    debugPrint(es.toString());
  }
}

void cancelNotification(int? notificationId) {
  if (notificationId != null) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  } else {
    _toastService.callToast("Notification id is null");
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  try {
    await setupLocator();

    if (message.data.isNotEmpty) {
      // Handle data message
      final dynamic data = message.data;
      debugPrint("SMA: myBackgroundMessageHandler data: $data");
      rootApiUrl = "https://social-media-app-l597.onrender.com";
      // if (!message.data.containsKey('launch') ||
      //     message.data['launch'] == 'false') {
      //   debugPrint("SMA: myBackgroundMessageHandler in background");
      //   _toastService.callToast("background");
      //   return;
      // }

      final response = await _apiService.getMessage(data["messageId"]);
      if (!response.isSuccessful()) return;
      final payload = response.responseGeneral.detail?.data["message"];
      if (data["action"] == "video_call") {
        createNotification(
          data["chatId"].hashCode,
          data["fullName"] ?? "Unknown",
          "Video call",
          true,
          payload,
        );
      } else {
        createNotification(
            data.hashCode, data["title"], data["body"], false, data);
      }
      // _navigationService.navigateToView(const BottomNavbarView(viewIndex: 1));
    }
    if (message.notification != null) {
      // Handle notification message
      final dynamic notification = message.notification;
      debugPrint("SMA: myBackgroundMessageHandler notification: $notification");
    }
  } catch (error, es) {
    debugPrint("SMA: myBackgroundMessageHandler ERROR");
    debugPrint(error.toString());
    debugPrint(es.toString());
  }
  // Or do other work.}
}

void initFirebaseNotification(
    ProfileProvider profileProvider,
    ChatProvider chatProvider,
    Function(Map<String, dynamic>) doWhenInForeground) async {
  FirebaseMessaging fmInstance = FirebaseMessaging.instance;
  RemoteMessage? remoteMessage = await fmInstance.getInitialMessage();
  if (remoteMessage != null) {
    myBackgroundMessageHandler(remoteMessage);
  }
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final data = message.data;
    debugPrint("SMA: initFirebaseNotification data:${message.data.toString()}");
    doWhenInForeground(message.data);
    if (message.data["action"] == "message" &&
            chatProvider.currentChat?.id == message.data["chatId"] ||
        data["action"] == "video_call") return;

    createNotification(data.hashCode, data["title"], data["body"], false, data);

    // _flutterLocalNotificationsPlugin.show(
    //   notification.hashCode,
    //   notification.title,
    //   notification.body,
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       _androidChannel.id,
    //       _androidChannel.name,
    //       channelDescription: _androidChannel.description,
    //       icon: '@mipmap/ic_launcher',
    //     ),
    //   ),
    //   payload: jsonEncode(message.toMap()),
    // );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    // just start app for now
    // pending
    // will navigate based on dynamic links or something similar
    if (message.data["action"] == "video_call") {}
    _toastService.callToast(message.data["action"] ?? "No data sent");
  });
  try {
    fmInstance.getToken().then((value) async {
      debugPrint("get token $value");
      if (value != null) {
        if (profileProvider.fcmToken != value) {
          final response = await _apiService.updateFcmToken(value);
          if (response.isSuccessful()) {
            profileProvider.updateFcmToken(value);
          } else {
            debugPrint("FCM token not updated");
          }
        }
      }
    });
  } catch (error, es) {
    debugPrint(error.toString());
    debugPrint(es.toString());
  }
  initNotifications();
}
