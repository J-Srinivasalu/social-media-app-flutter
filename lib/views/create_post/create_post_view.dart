import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_post_viewmodel.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => CreatePostViewModel());
  }
}
