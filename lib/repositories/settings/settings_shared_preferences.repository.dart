import 'package:calendaroo/models/settings/settings.model.dart';
import 'package:calendaroo/repositories/settings/settings.repository.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  @override
  Future<Settings> read() async {
    var notificationsEnabled = SharedPreferenceService().enableNotifications;

    return Settings(notificationsEnabled);
  }

  @override
  Future<void> write(Settings settings) async {
    SharedPreferenceService().setEnableNotifications(settings.notificationsEnabled);

  }
}
