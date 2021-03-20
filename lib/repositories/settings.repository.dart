import 'package:calendaroo/models/settings.dart';

abstract class SettingsRepository {
  Future<Settings> read();

  Future<void> write(Settings settings);
}
