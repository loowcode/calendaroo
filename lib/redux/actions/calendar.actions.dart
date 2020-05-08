import 'package:calendaroo/model/event.dart';

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

class FetchEventsList {}

class OpenEvent {
  final Event event;

  OpenEvent(this.event);
}

class EditEvent {
  final Event event;

  EditEvent(this.event);
}
