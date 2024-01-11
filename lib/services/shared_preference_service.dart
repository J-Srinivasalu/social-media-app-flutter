import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferenceService implements InitializableDependency {
  static SharedPreferenceService? _instance;
  static SharedPreferences? _sharedPreferences;

  String? getToken() => _sharedPreferences?.getString(LOCAL_STORAGE_KEY_TOKEN);

  Future<void> setToken(String token) async {
    await _sharedPreferences?.setString(LOCAL_STORAGE_KEY_TOKEN, token);
  }

  String? getRefreshToken() =>
      _sharedPreferences?.getString(LOCAL_STORAGE_KEY_REFRESH_TOKEN);

  Future<void> setRefreshToken(String refreshToken) async {
    await _sharedPreferences?.setString(
        LOCAL_STORAGE_KEY_REFRESH_TOKEN, refreshToken);
  }

  @override
  Future<void> init() async {
    if (_instance == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPreferenceService();
    }
  }
}
