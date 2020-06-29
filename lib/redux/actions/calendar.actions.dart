import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event.model.dart';

class LoadedEventsList {
  List<Event> events;

  LoadedEventsList(this.events);
}

class AddEvent {
  final Event event;

  AddEvent(this.event);
}

class RemoveEvent {
  final Event event;

  RemoveEvent(this.event);
}


class OpenEvent {
  final int eventId;

  OpenEvent(this.eventId);
}

class FocusEvent {
  final Event event;

  FocusEvent(this.event);
}

class EditEvent {
  final Event newEvent;

  EditEvent(this.newEvent);
}

class SelectDay {
  final Date day;

  SelectDay(this.day);
}
