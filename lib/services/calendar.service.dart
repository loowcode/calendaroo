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

  Map<DateTime, List<Event>> toMap(List<Event> events) {
    Map<DateTime, List<Event>> result = new Map();
    events.forEach((Event elem) {
      List<Event> list = result.putIfAbsent(elem.start, () => [elem]);
      if (list.length > 1) {
        list.add(elem);
      }
    });
    return result;
  }
}

CalendarService calendarService = CalendarService();
