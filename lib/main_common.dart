import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/helpers/flavor_config.dart';
import 'package:social_media_app/providers/chat_provider.dart';
import 'package:social_media_app/providers/post_provider.dart';
import 'package:social_media_app/providers/profile_provider.dart';
import 'package:social_media_app/services/connectivity_service.dart';
import 'package:social_media_app/services/environment_service.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/utils/enums.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void mainCommon(FlavorConfig flavorConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupLocator();
  rootApiUrl = flavorConfig.apiEndpoint![Endpoints.SERVER_URL] ?? "";
  final environmentService = locator<EnvironmentService>();
  environmentService.setFlavorType(flavorConfig.flavorType);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  static const primaryColor = CustomColors.blueDarkestColor;

  const SocialMediaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          initialData: ConnectivityStatus.OFFLINE,
          create: (_) {
            final connectionService = locator<ConnectivityService>();
            connectionService.setConnectivityService();
            return connectionService.connectionStatusController.stream;
          },
        ),
        ChangeNotifierProvider<ProfileProvider>(
            create: ((context) => ProfileProvider())),
        ChangeNotifierProvider<PostProvider>(
            create: ((context) => PostProvider())),
        ChangeNotifierProvider<ChatProvider>(
            create: ((context) => ChatProvider())),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
