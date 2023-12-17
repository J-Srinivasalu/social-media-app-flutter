import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils/dummy_data.dart';
import 'package:stacked/stacked.dart';

class PublicProfileViewModel extends BaseViewModel {
  User user = User(fullName: "");
  List<Post> posts = [];

  void initialize(User userPublicProfile) {
    user = userPublicProfile;
    posts = DummyData.posts
        .where((post) => user.username == post.user.username)
        .toList();
  }
}
