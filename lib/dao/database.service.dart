import 'package:calendaroo/dao/event-instances.repository.dart';
import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:uuid/uuid.dart';

import '../utils/calendar.utils.dart';
import 'events.repository.dart';

class DatabaseService {
  final _uuid = Uuid();

  Future<int> saveEvent(Event event) async {
    // Get a reference to the database.
    var id = await EventsRepository().insertEvent(event);

    var first = CalendarUtils.removeTime(event.start);
    var index = CalendarUtils.removeTime(event.start);
    var last = CalendarUtils.removeTime(event.end);

    var daySpan = last.difference(first).inDays;
    for (var i = 0; i <= daySpan; i++) {
      EventInstanceRepository().insertInstance(EventInstance(
        id: null,
        uuid: _uuid.v4(),
        eventId: id,
        start: DateTime(
          index.year,
          index.month,
          index.day,
          i == 0 ? event.start.hour : 0,
          i == 0 ? event.start.minute : 0,
        ),
        end: DateTime(
          index.year,
          index.month,
          index.day,
          i == daySpan ? event.end.hour : 23,
          i == daySpan ? event.end.minute : 59,
        ),
      ));
      index = index.add(Duration(days: 1));
    }

    return id;
  }

  Future getEvents(Date date) async{
    final events = await EventsRepository().nearEvents(date);
    final instance = await EventInstanceRepository().nearEvents(date);
  }
}
