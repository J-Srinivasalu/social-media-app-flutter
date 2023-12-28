// import 'package:stacked/stacked_annotations.dart';

import 'package:social_media_app/services/api_service.dart';
import 'package:social_media_app/services/environment_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/views/create_post/create_post_view.dart';
import 'package:social_media_app/views/friends/friend_requests_view.dart';
import 'package:social_media_app/views/friends/friend_view.dart';
import 'package:social_media_app/views/home/single_post_view.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/main_navigation/bottom_navbar_view.dart';
import 'package:social_media_app/views/profile/edit_profile_view.dart';
import 'package:social_media_app/views/public_profile/public_profile_view.dart';
import 'package:social_media_app/views/register/register_view.dart';
import 'package:social_media_app/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: BottomNavbarView, name: 'bottomNavbarViewRoute'),
  MaterialRoute(page: CreatePostView, name: 'createPostViewRoute'),
  MaterialRoute(page: LoginView, name: 'loginViewRoute'),
  MaterialRoute(page: RegisterView, name: 'registerViewRoute'),
  MaterialRoute(page: SinglePostView, name: 'singlePostViewRoute'),
  MaterialRoute(page: EditProfileView, name: 'editProfileViewRoute'),
  MaterialRoute(page: PublicProfileView, name: 'publicProfileViewRoute'),
  MaterialRoute(page: FriendRequestView, name: 'friendRequestViewRoute'),
  MaterialRoute(page: FriendView, name: 'friendViewRoute'),
], dependencies: [
  LazySingleton(classType: EnvironmentService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: ToastService),
  LazySingleton(classType: ApiService),
  InitializableSingleton(
    classType: SharedPreferenceService,
  ),
])
class App {}
