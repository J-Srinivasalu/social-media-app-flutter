import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/widgets/post_tile.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostProvider _postProvider = Provider.of<PostProvider>(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: _postProvider.posts.length,
            itemBuilder: (context, index) => PostTile(
              post: _postProvider.posts[index],
              fromHome: true,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
