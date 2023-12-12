import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/helpers/flavor_config.dart';
import 'package:social_media_app/services/environment_service.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/enums.dart';
import 'package:stacked_services/stacked_services.dart';

void mainCommon(FlavorConfig flavorConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupLocator();
  rootApiUrl = flavorConfig.apiEndpoint![Endpoints.SERVER_URL] ?? "";
  final _environmentService = locator<EnvironmentService>();
  _environmentService.setFlavorType(flavorConfig.flavorType);

  runApp(SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  static const primaryColor = CustomColors.blueDarkestColor;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
      ),
    );
  }
}
