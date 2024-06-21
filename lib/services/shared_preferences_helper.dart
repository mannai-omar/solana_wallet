import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences _prefs;

  // Initialize shared preferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get the stored token
  static String getToken() {
    return _prefs.getString('token') ?? '';
  }

  // Store the token
  static Future<bool> setToken(String token) {
    return _prefs.setString('token', token);
  }

  // Clear the stored token
  static Future<bool> clearToken() {
    return _prefs.remove('token');
  }
}
