import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/model/mocks/eventsList.mock.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';

class CalendarService {
  Future<List<Event>> eventsList() async {
    if (await sharedPreferenceService.environment == 'develop') {
      return eventsListMock;
    } else {
      return List<Event>();
    }
  }
}

CalendarService calendarService = CalendarService();
