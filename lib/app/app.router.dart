// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:social_media_app/models/notification_action.dart' as _i18;
import 'package:social_media_app/models/post.dart' as _i19;
import 'package:social_media_app/models/user.dart' as _i20;
import 'package:social_media_app/views/chat/chats_view.dart' as _i12;
import 'package:social_media_app/views/chat/individual_chat_view.dart' as _i13;
import 'package:social_media_app/views/chat/new_message_view.dart' as _i14;
import 'package:social_media_app/views/chat/video/video_call_offer_view.dart'
    as _i16;
import 'package:social_media_app/views/chat/video/video_call_view.dart' as _i15;
import 'package:social_media_app/views/create_post/create_post_view.dart'
    as _i4;
import 'package:social_media_app/views/friends/friend_requests_view.dart'
    as _i10;
import 'package:social_media_app/views/friends/friend_view.dart' as _i11;
import 'package:social_media_app/views/home/single_post_view.dart' as _i7;
import 'package:social_media_app/views/login/login_view.dart' as _i5;
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart'
    as _i3;
import 'package:social_media_app/views/profile/edit_profile_view.dart' as _i8;
import 'package:social_media_app/views/public_profile/public_profile_view.dart'
    as _i9;
import 'package:social_media_app/views/register/register_view.dart' as _i6;
import 'package:social_media_app/views/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i21;

class Routes {
  static const splashView = '/';

  static const bottomNavbarViewRoute = '/bottom-navbar-view';

  static const createPostViewRoute = '/create-post-view';

  static const loginViewRoute = '/login-view';

  static const registerViewRoute = '/register-view';

  static const singlePostViewRoute = '/single-post-view';

  static const editProfileViewRoute = '/edit-profile-view';

  static const publicProfileViewRoute = '/public-profile-view';

  static const friendRequestViewRoute = '/friend-request-view';

  static const friendViewRoute = '/friend-view';

  static const chatsViewRoute = '/chats-view';

  static const individualChatViewRoute = '/individual-chat-view';

  static const newMessageViewRoute = '/new-message-view';

  static const videoCallViewRoute = '/video-call-view';

  static const videoCallOfferViewRoute = '/video-call-offer-view';

  static const all = <String>{
    splashView,
    bottomNavbarViewRoute,
    createPostViewRoute,
    loginViewRoute,
    registerViewRoute,
    singlePostViewRoute,
    editProfileViewRoute,
    publicProfileViewRoute,
    friendRequestViewRoute,
    friendViewRoute,
    chatsViewRoute,
    individualChatViewRoute,
    newMessageViewRoute,
    videoCallViewRoute,
    videoCallOfferViewRoute,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.bottomNavbarViewRoute,
      page: _i3.BottomNavbarView,
    ),
    _i1.RouteDef(
      Routes.createPostViewRoute,
      page: _i4.CreatePostView,
    ),
    _i1.RouteDef(
      Routes.loginViewRoute,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerViewRoute,
      page: _i6.RegisterView,
    ),
    _i1.RouteDef(
      Routes.singlePostViewRoute,
      page: _i7.SinglePostView,
    ),
    _i1.RouteDef(
      Routes.editProfileViewRoute,
      page: _i8.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.publicProfileViewRoute,
      page: _i9.PublicProfileView,
    ),
    _i1.RouteDef(
      Routes.friendRequestViewRoute,
      page: _i10.FriendRequestView,
    ),
    _i1.RouteDef(
      Routes.friendViewRoute,
      page: _i11.FriendView,
    ),
    _i1.RouteDef(
      Routes.chatsViewRoute,
      page: _i12.ChatsView,
    ),
    _i1.RouteDef(
      Routes.individualChatViewRoute,
      page: _i13.IndividualChatView,
    ),
    _i1.RouteDef(
      Routes.newMessageViewRoute,
      page: _i14.NewMessageView,
    ),
    _i1.RouteDef(
      Routes.videoCallViewRoute,
      page: _i15.VideoCallView,
    ),
    _i1.RouteDef(
      Routes.videoCallOfferViewRoute,
      page: _i16.VideoCallOfferView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.BottomNavbarView: (data) {
      final args = data.getArgs<BottomNavbarViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.BottomNavbarView(
            key: args.key,
            viewIndex: args.viewIndex,
            notificationAction: args.notificationAction,
            data: args.data),
        settings: data,
      );
    },
    _i4.CreatePostView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CreatePostView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(key: args.key),
        settings: data,
      );
    },
    _i6.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i7.SinglePostView: (data) {
      final args = data.getArgs<SinglePostViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.SinglePostView(key: args.key, post: args.post),
        settings: data,
      );
    },
    _i8.EditProfileView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.EditProfileView(),
        settings: data,
      );
    },
    _i9.PublicProfileView: (data) {
      final args = data.getArgs<PublicProfileViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.PublicProfileView(
            key: args.key, userPublicProfile: args.userPublicProfile),
        settings: data,
      );
    },
    _i10.FriendRequestView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.FriendRequestView(),
        settings: data,
      );
    },
    _i11.FriendView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.FriendView(),
        settings: data,
      );
    },
    _i12.ChatsView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.ChatsView(),
        settings: data,
      );
    },
    _i13.IndividualChatView: (data) {
      final args = data.getArgs<IndividualChatViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.IndividualChatView(
            key: args.key, friend: args.friend, chatId: args.chatId),
        settings: data,
      );
    },
    _i14.NewMessageView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.NewMessageView(),
        settings: data,
      );
    },
    _i15.VideoCallView: (data) {
      final args = data.getArgs<VideoCallViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.VideoCallView(
            key: args.key,
            user: args.user,
            chatId: args.chatId,
            offer: args.offer,
            messageId: args.messageId),
        settings: data,
      );
    },
    _i16.VideoCallOfferView: (data) {
      final args = data.getArgs<VideoCallOfferViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.VideoCallOfferView(
            key: args.key,
            friend: args.friend,
            chatId: args.chatId,
            messageId: args.messageId,
            offer: args.offer,
            offerAccepted: args.offerAccepted,
            receiverId: args.receiverId),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class BottomNavbarViewArguments {
  const BottomNavbarViewArguments({
    this.key,
    required this.viewIndex,
    this.notificationAction,
    this.data,
  });

  final _i17.Key? key;

  final int viewIndex;

  final _i18.NotificationAction? notificationAction;

  final Map<String, String>? data;

  @override
  String toString() {
    return '{"key": "$key", "viewIndex": "$viewIndex", "notificationAction": "$notificationAction", "data": "$data"}';
  }

  @override
  bool operator ==(covariant BottomNavbarViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.viewIndex == viewIndex &&
        other.notificationAction == notificationAction &&
        other.data == data;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        viewIndex.hashCode ^
        notificationAction.hashCode ^
        data.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RegisterViewArguments {
  const RegisterViewArguments({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RegisterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SinglePostViewArguments {
  const SinglePostViewArguments({
    this.key,
    required this.post,
  });

  final _i17.Key? key;

  final _i19.Post post;

  @override
  String toString() {
    return '{"key": "$key", "post": "$post"}';
  }

  @override
  bool operator ==(covariant SinglePostViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.post == post;
  }

  @override
  int get hashCode {
    return key.hashCode ^ post.hashCode;
  }
}

class PublicProfileViewArguments {
  const PublicProfileViewArguments({
    this.key,
    required this.userPublicProfile,
  });

  final _i17.Key? key;

  final _i20.User userPublicProfile;

  @override
  String toString() {
    return '{"key": "$key", "userPublicProfile": "$userPublicProfile"}';
  }

  @override
  bool operator ==(covariant PublicProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.userPublicProfile == userPublicProfile;
  }

  @override
  int get hashCode {
    return key.hashCode ^ userPublicProfile.hashCode;
  }
}

class IndividualChatViewArguments {
  const IndividualChatViewArguments({
    this.key,
    required this.friend,
    required this.chatId,
  });

  final _i17.Key? key;

  final _i20.User friend;

  final String chatId;

  @override
  String toString() {
    return '{"key": "$key", "friend": "$friend", "chatId": "$chatId"}';
  }

  @override
  bool operator ==(covariant IndividualChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.friend == friend && other.chatId == chatId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ friend.hashCode ^ chatId.hashCode;
  }
}

class VideoCallViewArguments {
  const VideoCallViewArguments({
    this.key,
    required this.user,
    required this.chatId,
    this.offer,
    this.messageId,
  });

  final _i17.Key? key;

  final _i20.User user;

  final String chatId;

  final String? offer;

  final String? messageId;

  @override
  String toString() {
    return '{"key": "$key", "user": "$user", "chatId": "$chatId", "offer": "$offer", "messageId": "$messageId"}';
  }

  @override
  bool operator ==(covariant VideoCallViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.user == user &&
        other.chatId == chatId &&
        other.offer == offer &&
        other.messageId == messageId;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        user.hashCode ^
        chatId.hashCode ^
        offer.hashCode ^
        messageId.hashCode;
  }
}

class VideoCallOfferViewArguments {
  const VideoCallOfferViewArguments({
    this.key,
    required this.friend,
    required this.chatId,
    required this.messageId,
    required this.offer,
    this.offerAccepted = false,
    required this.receiverId,
  });

  final _i17.Key? key;

  final _i20.User friend;

  final String chatId;

  final String messageId;

  final String offer;

  final bool offerAccepted;

  final String receiverId;

  @override
  String toString() {
    return '{"key": "$key", "friend": "$friend", "chatId": "$chatId", "messageId": "$messageId", "offer": "$offer", "offerAccepted": "$offerAccepted", "receiverId": "$receiverId"}';
  }

  @override
  bool operator ==(covariant VideoCallOfferViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.friend == friend &&
        other.chatId == chatId &&
        other.messageId == messageId &&
        other.offer == offer &&
        other.offerAccepted == offerAccepted &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        friend.hashCode ^
        chatId.hashCode ^
        messageId.hashCode ^
        offer.hashCode ^
        offerAccepted.hashCode ^
        receiverId.hashCode;
  }
}

extension NavigatorStateExtension on _i21.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavbarViewRoute({
    _i17.Key? key,
    required int viewIndex,
    _i18.NotificationAction? notificationAction,
    Map<String, String>? data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bottomNavbarViewRoute,
        arguments: BottomNavbarViewArguments(
            key: key,
            viewIndex: viewIndex,
            notificationAction: notificationAction,
            data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreatePostViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createPostViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginViewRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginViewRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterViewRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerViewRoute,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSinglePostViewRoute({
    _i17.Key? key,
    required _i19.Post post,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.singlePostViewRoute,
        arguments: SinglePostViewArguments(key: key, post: post),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPublicProfileViewRoute({
    _i17.Key? key,
    required _i20.User userPublicProfile,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.publicProfileViewRoute,
        arguments: PublicProfileViewArguments(
            key: key, userPublicProfile: userPublicProfile),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFriendRequestViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.friendRequestViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFriendViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.friendViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatsViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chatsViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIndividualChatViewRoute({
    _i17.Key? key,
    required _i20.User friend,
    required String chatId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.individualChatViewRoute,
        arguments: IndividualChatViewArguments(
            key: key, friend: friend, chatId: chatId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewMessageViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newMessageViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVideoCallViewRoute({
    _i17.Key? key,
    required _i20.User user,
    required String chatId,
    String? offer,
    String? messageId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.videoCallViewRoute,
        arguments: VideoCallViewArguments(
            key: key,
            user: user,
            chatId: chatId,
            offer: offer,
            messageId: messageId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVideoCallOfferViewRoute({
    _i17.Key? key,
    required _i20.User friend,
    required String chatId,
    required String messageId,
    required String offer,
    bool offerAccepted = false,
    required String receiverId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.videoCallOfferViewRoute,
        arguments: VideoCallOfferViewArguments(
            key: key,
            friend: friend,
            chatId: chatId,
            messageId: messageId,
            offer: offer,
            offerAccepted: offerAccepted,
            receiverId: receiverId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomNavbarViewRoute({
    _i17.Key? key,
    required int viewIndex,
    _i18.NotificationAction? notificationAction,
    Map<String, String>? data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bottomNavbarViewRoute,
        arguments: BottomNavbarViewArguments(
            key: key,
            viewIndex: viewIndex,
            notificationAction: notificationAction,
            data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreatePostViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createPostViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginViewRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginViewRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterViewRoute({
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.registerViewRoute,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSinglePostViewRoute({
    _i17.Key? key,
    required _i19.Post post,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.singlePostViewRoute,
        arguments: SinglePostViewArguments(key: key, post: post),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPublicProfileViewRoute({
    _i17.Key? key,
    required _i20.User userPublicProfile,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.publicProfileViewRoute,
        arguments: PublicProfileViewArguments(
            key: key, userPublicProfile: userPublicProfile),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFriendRequestViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.friendRequestViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFriendViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.friendViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatsViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chatsViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIndividualChatViewRoute({
    _i17.Key? key,
    required _i20.User friend,
    required String chatId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.individualChatViewRoute,
        arguments: IndividualChatViewArguments(
            key: key, friend: friend, chatId: chatId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewMessageViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newMessageViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVideoCallViewRoute({
    _i17.Key? key,
    required _i20.User user,
    required String chatId,
    String? offer,
    String? messageId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.videoCallViewRoute,
        arguments: VideoCallViewArguments(
            key: key,
            user: user,
            chatId: chatId,
            offer: offer,
            messageId: messageId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVideoCallOfferViewRoute({
    _i17.Key? key,
    required _i20.User friend,
    required String chatId,
    required String messageId,
    required String offer,
    bool offerAccepted = false,
    required String receiverId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.videoCallOfferViewRoute,
        arguments: VideoCallOfferViewArguments(
            key: key,
            friend: friend,
            chatId: chatId,
            messageId: messageId,
            offer: offer,
            offerAccepted: offerAccepted,
            receiverId: receiverId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
