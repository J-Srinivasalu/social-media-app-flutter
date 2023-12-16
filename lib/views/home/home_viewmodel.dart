import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Post> posts = [];
  List<Post> get sortedPosts => posts
    ..sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return b.createdAt!.compareTo(a.createdAt!);
    });

  initialize() {
    posts.addAll([
      Post(
        id: '1',
        user: User(
            email: 'some@mail.com', fullName: 'Jackson', username: '@jackson'),
        content: 'This is the first post!',
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user2'],
        comments: ['comment1', 'comment2'],
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        user: User(
            email: 'jane@mail.com', fullName: 'Jane Smith', username: "@jane"),
        content: 'Another post here!',
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg',
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user3', 'user4', 'user4', 'user4', 'user4'],
        comments: ['comment3', 'comment4'],
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
      Post(
        id: '3',
        user: User(
            email: 'some@mail.com', fullName: 'Jackson', username: '@jackson'),
        content:
            'Cillum commodo ea nulla eiusmod irure consequat reprehenderit excepteur. Dolor anim dolor dolor eu consectetur sit. Tempor eu culpa ullamco ea.',
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user1', 'user2', 'user4'],
        comments: ['comment1', 'comment2'],
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: '4',
        user: User(
            email: 'jane@mail.com', fullName: 'Jane Smith', username: "@jane"),
        content: 'Another post here!',
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg',
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user3', 'user4'],
        comments: ['comment3', 'comment4', 'user4', 'user4', 'user4', 'user4'],
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
      Post(
        id: '5',
        user: User(
            email: 'some@mail.com', fullName: 'Jackson', username: '@jackson'),
        content:
            """Irure veniam do voluptate laboris eiusmod ex eu deserunt sunt exercitation aliquip occaecat. Esse exercitation cillum esse mollit eiusmod esse tempor Lorem duis pariatur incididunt. Do commodo sunt adipisicing do anim. Sit culpa reprehenderit culpa reprehenderit eu nulla magna. Non ullamco aute do adipisicing exercitation proident esse excepteur cupidatat. Sint incididunt enim magna excepteur veniam tempor eu. Duis eiusmod exercitation aliquip ex do nostrud ea anim labore sit Lorem pariatur id.

Occaecat veniam elit et ea aliquip excepteur eiusmod culpa amet elit et ipsum consectetur. Duis culpa incididunt do adipisicing sunt culpa cupidatat ea aliqua. Sit mollit laborum mollit nulla proident aliquip reprehenderit enim aliquip adipisicing nisi eu. Cillum adipisicing quis consectetur aliquip ad esse cillum nostrud enim et et laborum enim id.

Sit commodo ullamco cupidatat anim excepteur nostrud consequat exercitation cillum ad consequat reprehenderit. Veniam duis do Lorem ullamco anim velit dolor deserunt. Sunt est voluptate excepteur ex eu tempor dolor. Consectetur aute dolor aliqua nisi nostrud reprehenderit ullamco ullamco.

Esse ad dolor laborum ex sit cupidatat deserunt. Occaecat dolore deserunt do eu reprehenderit voluptate non mollit laboris. Incididunt est officia pariatur amet Lorem non proident duis culpa enim esse incididunt voluptate. Occaecat adipisicing irure in exercitation in laboris sit quis exercitation. Excepteur consequat anim ipsum excepteur pariatur exercitation nulla id. Consequat nostrud ullamco dolore non.

Sunt amet commodo est cillum culpa quis mollit ipsum tempor ex excepteur. Aliquip qui nisi ea sit ut. Ea non labore quis voluptate elit pariatur occaecat aliqua fugiat excepteur id laboris adipisicing. Dolore sunt pariatur dolore aute amet ut laboris ullamco veniam nostrud labore nulla. Enim qui eu sint et voluptate laboris in qui do. Ex ipsum minim consequat in occaecat mollit proident aliqua.""",
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user1', 'user2'],
        comments: ['comment1', 'comment2'],
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: '6',
        user: User(
            email: 'jane@mail.com', fullName: 'Jane Smith', username: "@jane"),
        content: 'Another post here!',
        media: [
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg',
          'https://images.freeimages.com/images/large-previews/d4f/www-1242368.jpg'
        ],
        likes: ['user3', 'user4'],
        comments: ['comment3', 'comment4'],
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ]);
  }

  void logout() {
    _navigationService.clearStackAndShow(Routes.loginViewRoute);
  }
}
