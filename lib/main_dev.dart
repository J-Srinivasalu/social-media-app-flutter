import 'package:social_media_app/models/helpers/flavor_config.dart';

import 'main_common.dart';
import 'utils/enums.dart';

void main() {
  mainCommon(FlavorConfig()
    ..appTitle = "Social media app DEV"
    ..flavorType = FlavorType.DEV
    ..apiEndpoint = {
      Endpoints.SERVER_URL: "http://localhost:4000",
      Endpoints.SENTRY_URL: ""
    });
}
