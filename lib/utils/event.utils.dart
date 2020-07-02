import 'package:calendaroo/model/event.model.dart';
import 'package:uuid/uuid.dart';

class EventUtils {
  static Event createNewEvent(
      {int id,
      String title,
      String description,
      DateTime start,
      DateTime end,
      bool allDay,
      Duration repeat,
      DateTime until}) {
    var uuid = Uuid();
    return Event(
        id: id,
        title: title,
        uuid: uuid.v4(),
        description: description,
        start: start,
        end: end,
        allDay: allDay,
        repeat: repeat,
        until: until);
  }
}
