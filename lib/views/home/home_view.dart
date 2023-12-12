import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => const Scaffold(
              body: Center(child: Text("your are at home!")),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
