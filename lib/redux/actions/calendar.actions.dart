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
  final Event event;

  OpenEvent(this.event);
}

class EditEvent {
  final Event newEvent;
  final Event oldEvent;

  EditEvent(this.oldEvent, this.newEvent);
}

class SelectDay {
  final DateTime day;

  SelectDay(this.day);
}
