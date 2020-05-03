import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences _prefs;

  Future<bool> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {
      print("shared prefrences error : $e");
      return false;
    });
    return true;
  }

  Future setString(String name, String value) async {
    await _prefs.setString(name, value);
  }

  Future setBool(String name, bool value) async {
    await _prefs.setBool(name, value);
  }

  Future remove(String name) async {
    await _prefs.remove(name);
  }

  Future clearAll() async {
    await _prefs.clear();
  }

  Future<String> get environment async => _prefs.getString('environment');
}

SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
