import 'package:calendaroo/models/settings/settings.model.dart';

abstract class CalendarRepository {
  Future<Settings> read();

  Future<void> write(Settings settings);
}
