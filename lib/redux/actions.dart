class LoadedEventsList {
  // TODO: an object for the event
  List<String> events;

  LoadedEventsList(this.events);
}

class AddEvent {
  // TODO: an object for the event
  final String event;

  AddEvent(this.event);
}

class RemoveEvent {
  final int id;

  RemoveEvent(this.id);
}
