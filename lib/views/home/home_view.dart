import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/widgets/post_tile.dart';
import 'package:social_media_app/widgets/refresh_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: model.postRefreshController,
            footer: const RefreshWidget(),
            onRefresh: () async {
              if (!model.isLoading) {
                await model.refreshPosts(postProvider);
              }
            },
            onLoading: () async {
              if (!model.isLoading) {
                await model.fetchPosts(postProvider);
              }
            },
            child: ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) => PostTile(
                key: ValueKey(postProvider.posts[index]),
                post: postProvider.posts[index],
                fromHome: true,
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
