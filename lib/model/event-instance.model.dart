import 'package:flutter/cupertino.dart';

class EventInstance {
  int id;
  String uuid;
  String title;
  int eventId;
  DateTime start;
  DateTime end;

  EventInstance(
      {@required this.id,
      @required this.uuid,
      @required this.eventId,
      @required this.title,
      @required this.start,
      @required this.end});

  factory EventInstance.fromMap(Map<String, dynamic> map) {
    return EventInstance(
      id: map['id'] as int,
      uuid: map['uuid'] as String,
      title: map['title'] as String,
      eventId: map['eventId'] as int,
      start: DateTime.parse(map['start'] as String),
      end: DateTime.parse(map['end'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['eventId'] = eventId;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    return map;
  }

  EventInstance copyWith(
      {int id,
      String uuid,
      int eventId,
      String title,
      DateTime start,
      DateTime end}) {
    return EventInstance(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        eventId: eventId ?? this.eventId,
        title: title ?? this.title,
        start: start ?? this.start,
        end: end ?? this.end);
  }
}
