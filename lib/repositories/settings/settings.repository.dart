import 'package:calendaroo/models/settings/settings.model.dart';

abstract class SettingsRepository {
  Future<Settings> read();

  Future<void> write(Settings settings);
}
