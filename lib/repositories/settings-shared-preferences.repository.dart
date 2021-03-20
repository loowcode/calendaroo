import 'package:calendaroo/models/settings.dart';
import 'package:calendaroo/repositories/settings.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  @override
  Future<Settings> read() async {
    var prefs = await SharedPreferences.getInstance();
    var notificationsEnabled = prefs.getBool('enableNotifications');

    return Settings(notificationsEnabled);
  }

  @override
  Future<void> write(Settings settings) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enableNotifications', settings.notificationsEnabled);
  }
}
