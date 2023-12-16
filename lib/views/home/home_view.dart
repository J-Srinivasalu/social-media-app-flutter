import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/post_tile.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: model.sortedPosts.length,
            itemBuilder: (context, index) =>
                PostTile(post: model.sortedPosts[index]),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.initialize(),
    );
  }
}
