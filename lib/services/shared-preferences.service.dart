//import 'package:shared_preferences/shared_preferences.dart';
//
//class SharedPreferenceService {
//  SharedPreferences _prefs;
//
//  Future<bool> getSharedPreferencesInstance() async {
//    _prefs = await SharedPreferences.getInstance().catchError((e) {
//      print("shared prefrences error : $e");
//      return false;
//    });
//    return true;
//  }
//
//  Future setString(String name, String value) async {
//    await _prefs.setString(name, value);
//  }
//
//  Future setBool(String name, bool value) async {
//    await _prefs.setBool(name, value);
//  }
//
//  Future remove(String name) async {
//    await _prefs.remove(name);
//  }
//
//  Future clearAll() async {
//    await _prefs.clear();
//  }
//
//  Future<String> get token async => _prefs.getString('accessToken');
//  Future<String> get tmpPhoneNumber async => _prefs.getString('tmpPhoneNumber');
//  Future<bool> get hundredKm async => _prefs.getBool('hundredKm');
//  Future<String> get subscribedContactList async => _prefs.getString('subscribedContactList');
//  Future<String> get localStorageFriends async => _prefs.getString('localStorageFriends');
//  Future<String> get listeners async => _prefs.getString('listeners');
//  Future<String> get listening async => _prefs.getString('listening');
//  Future<bool> get hasSeenIntroduction async => _prefs.getBool('hasSeenIntroduction');
//  Future<String> get userCountryPhoneCode async => _prefs.getString('userCountryPhoneCode');
//}
//
//SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
