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


}