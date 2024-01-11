import 'package:flutter/material.dart';
import 'package:social_media_app/utils/custom_colors.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.wifi_off_rounded,
                color: CustomColors.primaryColor,
                size: 100.0,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'No internet Connection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please check your internet connection and try again.',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
