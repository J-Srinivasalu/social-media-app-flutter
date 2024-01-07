import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/views/friends/friend_requests_view.dart';
import 'package:social_media_app/views/friends/friend_view.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:social_media_app/views/profile/edit_profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedPreferenceService = locator<SharedPreferenceService>();

  void logout(ProfileProvider profileProvider, PostProvider postProvider,
      ChatProvider chatProvider) {
    _sharedPreferenceService.setToken("");
    profileProvider.reset();
    postProvider.reset();
    chatProvider.reset();
    _navigationService.clearStackAndShowView(LoginView());
  }

  void navigateToEditProfile() {
    _navigationService.navigateToView(const EditProfileView());
  }

  void navigateToFriendRequestView() {
    _navigationService.navigateToView(const FriendRequestView());
  }

  void navigateToFriendView() {
    _navigationService.navigateToView(const FriendView());
  }
}
