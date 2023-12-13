import 'package:flutter/material.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => const Scaffold(
        backgroundColor: CustomColors.primaryColor,
        body: Center(
          child: Text(
            "SMA",
            style: TextStyle(color: CustomColors.whiteColor, fontSize: 32),
          ),
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.initialize(),
    );
  }
}
