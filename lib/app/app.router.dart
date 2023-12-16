// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post.dart' as _i10;
import 'package:social_media_app/views/create_post/create_post_view.dart'
    as _i4;
import 'package:social_media_app/views/home/single_post_view.dart' as _i7;
import 'package:social_media_app/views/login/login_view.dart' as _i5;
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart'
    as _i3;
import 'package:social_media_app/views/profile/edit_profile_view.dart' as _i8;
import 'package:social_media_app/views/register/register_view.dart' as _i6;
import 'package:social_media_app/views/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const splashView = '/';

  static const bottomNavbarViewRoute = '/bottom-navbar-view';

  static const createPostViewRoute = '/create-post-view';

  static const loginViewRoute = '/login-view';

  static const registerViewRoute = '/register-view';

  static const singlePostViewRoute = '/single-post-view';

  static const editProfileViewRoute = '/edit-profile-view';

  static const all = <String>{
    splashView,
    bottomNavbarViewRoute,
    createPostViewRoute,
    loginViewRoute,
    registerViewRoute,
    singlePostViewRoute,
    editProfileViewRoute,
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
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.BottomNavbarView: (data) {
      final args = data.getArgs<BottomNavbarViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.BottomNavbarView(key: args.key, viewIndex: args.viewIndex),
        settings: data,
      );
    },
    _i4.CreatePostView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CreatePostView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.RegisterView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.RegisterView(),
        settings: data,
      );
    },
    _i7.SinglePostView: (data) {
      final args = data.getArgs<SinglePostViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.SinglePostView(key: args.key, post: args.post),
        settings: data,
      );
    },
    _i8.EditProfileView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.EditProfileView(),
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

  final _i9.Key? key;

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

class SinglePostViewArguments {
  const SinglePostViewArguments({
    this.key,
    required this.post,
  });

  final _i9.Key? key;

  final _i10.Post post;

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

extension NavigatorStateExtension on _i11.NavigationService {
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
    _i9.Key? key,
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

  Future<dynamic> navigateToLoginViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSinglePostViewRoute({
    _i9.Key? key,
    required _i10.Post post,
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
    _i9.Key? key,
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

  Future<dynamic> replaceWithLoginViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterViewRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerViewRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSinglePostViewRoute({
    _i9.Key? key,
    required _i10.Post post,
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
}
