import 'package:social_media_app/models/helpers/flavor_config.dart';

import 'main_common.dart';
import 'utils/enums.dart';

void main() {
  mainCommon(FlavorConfig()
    ..appTitle = "Social media app"
    ..flavorType = FlavorType.PROD
    ..apiEndpoint = {
      Endpoints.SERVER_URL: "https://social-media-app-l597.onrender.com",
      Endpoints.SENTRY_URL: ""
    });
}
