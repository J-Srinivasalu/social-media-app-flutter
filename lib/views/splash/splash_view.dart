import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(child: Text("Welcome, everything works")),
      ),
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.initialize(),
    );
  }
}
