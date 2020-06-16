import 'package:calendaroo/dao/event-instances.repository.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:uuid/uuid.dart';

import '../utils/calendar.utils.dart';
import 'events.repository.dart';

class DatabaseService {
  Future<int> saveEvent(Event event) async {
    // Get a reference to the database.
   var id = await EventsRepository().insertEvent(event);

    DateTime first = CalendarUtils.removeTime(event.start);
    DateTime index = CalendarUtils.removeTime(event.start);
    DateTime last = CalendarUtils.removeTime(event.end);
    var uuid = Uuid();
    for (var i = 0; i <= last.difference(first).inDays; i++) {
      EventInstanceRepository().insertInstance(EventInstance(
        id: null,
        uuid: uuid.v4(),
        eventId: id,
        start: event.start,
        end: event.end
      ));
      index = index.add(Duration(days: 1));
    }

    return id;
  }

  /*
  Event _saveEvent(CalendarState state, Event event) {
  DateTime index = CalendarService().removeTime(event.start);
  DateTime first = CalendarService().removeTime(event.start);
  DateTime last = CalendarService().removeTime(event.start);
  while (index.isBefore(last)) {
    // if event has a multidays duration
    if (index.difference(first).inDays == 0) {
      // if first day
      _inserIntoStore(
          state,
          _createNewEvent(
              event.title,
              event.description,
              DateTime(event.start.year, event.start.month, event.start.day,
                  event.start.hour, event.start.minute),
              DateTime(event.start.year, event.start.month, event.start.day, 23,
                  59)));
    } else {
      // if middle days
      _inserIntoStore(
          state,
          _createNewEvent(
              event.title,
              event.description,
              DateTime(index.year, index.month, index.day, 0, 0),
              DateTime(index.year, index.month, index.day, 23, 59)));
    }

    index = index.add(Duration(days: 1));
  }
  var hour;
  var minute;
  if (first.difference(last).inDays == 0) {
    // event with a one day duration
    hour = event.start.hour;
    minute = event.start.minute;
  } else {
    // if last day of a multidays event
    hour = 0;
    minute = 0;
  }
  _inserIntoStore(
      state,
      _createNewEvent(
          event.title,
          event.description,
          DateTime(index.year, index.month, index.day, hour, minute),
          DateTime(event.end.year, event.end.month, event.end.day,
              event.end.hour, event.end.minute)));
}

    **/


}