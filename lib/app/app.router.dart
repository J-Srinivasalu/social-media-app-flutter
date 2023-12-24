// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart' as _i11;
import 'package:social_media_app/models/user.dart' as _i12;
import 'package:social_media_app/views/create_post/create_post_view.dart'
    as _i4;
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
import 'package:stacked_services/stacked_services.dart' as _i13;

class Routes {
  static const splashView = '/';

  static const bottomNavbarViewRoute = '/bottom-navbar-view';

  static const createPostViewRoute = '/create-post-view';

  static const loginViewRoute = '/login-view';

  static const registerViewRoute = '/register-view';

  static const singlePostViewRoute = '/single-post-view';

  static const editProfileViewRoute = '/edit-profile-view';

  static const publicProfileViewRoute = '/public-profile-view';

  static const all = <String>{
    splashView,
    bottomNavbarViewRoute,
    createPostViewRoute,
    loginViewRoute,
    registerViewRoute,
    singlePostViewRoute,
    editProfileViewRoute,
    publicProfileViewRoute,
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
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.BottomNavbarView: (data) {
      final args = data.getArgs<BottomNavbarViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.BottomNavbarView(key: args.key, viewIndex: args.viewIndex),
        settings: data,
      );
    },
    _i4.CreatePostView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CreatePostView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(key: args.key),
        settings: data,
      );
    },
    _i6.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i7.SinglePostView: (data) {
      final args = data.getArgs<SinglePostViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.SinglePostView(key: args.key, post: args.post),
        settings: data,
      );
    },
    _i8.EditProfileView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.EditProfileView(),
        settings: data,
      );
    },
    _i9.PublicProfileView: (data) {
      final args = data.getArgs<PublicProfileViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.PublicProfileView(
            key: args.key, userPublicProfile: args.userPublicProfile),
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
  });

  final _i10.Key? key;

  final int viewIndex;

  @override
  String toString() {
    return '{"key": "$key", "viewIndex": "$viewIndex"}';
  }

  @override
  bool operator ==(covariant BottomNavbarViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.viewIndex == viewIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^ viewIndex.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i10.Key? key;

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

  final _i10.Key? key;

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

  final _i10.Key? key;

  final _i11.Post post;

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

  final _i10.Key? key;

  final _i12.User userPublicProfile;

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

extension NavigatorStateExtension on _i13.NavigationService {
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
    _i10.Key? key,
    required int viewIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bottomNavbarViewRoute,
        arguments: BottomNavbarViewArguments(key: key, viewIndex: viewIndex),
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
    _i10.Key? key,
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
    _i10.Key? key,
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
    _i10.Key? key,
    required _i11.Post post,
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
    _i10.Key? key,
    required _i12.User userPublicProfile,
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
    _i10.Key? key,
    required int viewIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bottomNavbarViewRoute,
        arguments: BottomNavbarViewArguments(key: key, viewIndex: viewIndex),
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
    _i10.Key? key,
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
    _i10.Key? key,
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
    _i10.Key? key,
    required _i11.Post post,
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
    _i10.Key? key,
    required _i12.User userPublicProfile,
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
}
