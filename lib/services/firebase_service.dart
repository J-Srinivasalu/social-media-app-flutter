import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:stacked_services/stacked_services.dart';

// setup for notifications
final _apiService = locator<ApiService>();
final _navigationService = locator<NavigationService>();
final _toastService = locator<ToastService>();

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _androidChannel = AndroidNotificationChannel(
  "sma_channel",
  "sma notifications",
  description: 'This channel is for sma notifications',
  importance: Importance.defaultImportance,
);

Future<void> initNotifications() async {
  var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings());

  _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification);

  final platform =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(_androidChannel);
}

Future onSelectNotification(NotificationResponse notificationResponse) async {
  String? payload = notificationResponse.payload;
  if (payload == null) {
    debugPrint("SMA: onSelectNotification no payload");
    return;
  }
  final message = RemoteMessage.fromMap(jsonDecode(payload));
  final data = message.data;
  final notification = message.notification;
  debugPrint("SMA: onSelectNotification data: $data");
  debugPrint("SMA: onSelectNotification notification: $notification");
  _navigationService.navigateToView(const BottomNavbarView(viewIndex: 1));
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    // Handle data message
    final dynamic data = message.data;
    debugPrint("SMA: myBackgroundMessageHandler data: $data");
    _navigationService.navigateToView(const BottomNavbarView(viewIndex: 1));
  }
  if (message.notification != null) {
    // Handle notification message
    final dynamic notification = message.notification;
    debugPrint("SMA: myBackgroundMessageHandler notification: $notification");
  }
  // Or do other work.
}

void initFirebaseNotification(
    ProfileProvider profileProvider,
    ChatProvider chatProvider,
    Function(Map<String, dynamic>) doWhenInForeground) {
  FirebaseMessaging fmInstance = FirebaseMessaging.instance;
  fmInstance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;
    debugPrint("SMA: initFirebaseNotification data:${message.data.toString()}");
    if (notification == null) return;
    doWhenInForeground(message.data);
    if (message.data["action"] == "message" &&
        chatProvider.currentChat?.id == message.data["chatId"]) return;
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    // just start app for now
    // pending
    // will navigate based on dynamic links or something similar
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
