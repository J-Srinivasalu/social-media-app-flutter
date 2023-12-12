import 'package:social_media_app/utils/enums.dart';

class EnvironmentService {
  FlavorType? _flavorType;

  FlavorType? get flavorType => _flavorType;

  void setFlavorType(FlavorType? flavorType) {
    _flavorType = flavorType;
  }
}
