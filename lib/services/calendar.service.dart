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
      var date = elem.start;
//      var date = DateTime(elem.start.year, elem.start.month, elem.start.day);
      if (result.containsKey(date)) {
        var list = result[date];
        list.add(elem);
        result[date] = list;
      } else {
        result.putIfAbsent(date, () => [elem]);
      }
    });
    return result;
  }
}

CalendarService calendarService = CalendarService();
