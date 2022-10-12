import 'package:shared_preferences/shared_preferences.dart';

class Pn2CacheManager {

  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<bool> set(String key, String value) async {
    final prefs = await _prefs;
    return prefs.setString(key, value);
  }

  static Future<String?> get(String key) async {
    final prefs = await _prefs;
    String? value = prefs.getString(key);
    return value;
  }

  static Future<bool> contains(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }

}
