import 'package:calendaroo/models/settings/settings.model.dart';
import 'package:calendaroo/repositories/settings/settings.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  static const ENABLE_NOTIFICATIONS = 'enableNotifications';

  @override
  Future<Settings> read() async {
    var prefs = await SharedPreferences.getInstance();
    var notificationsEnabled = prefs.getBool(ENABLE_NOTIFICATIONS);

    return Settings(notificationsEnabled);
  }

  @override
  Future<void> write(Settings settings) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ENABLE_NOTIFICATIONS, settings.notificationsEnabled);
  }
}
