import 'package:flutter/cupertino.dart';

class Event {
  int id;
  String uuid;
  String title;
  String description;
  DateTime start;
  DateTime end;
  Duration repeat;

  Event(
      {@required this.id,
      @required this.uuid,
      this.title,
      this.description,
      this.start,
      this.end,
      this.repeat});

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int,
      title: map['title'] as String,
      uuid: map['uuid'] as String,
      description: map['description'] as String,
      start: DateTime.parse(map['start'] as String),
      end: DateTime.parse(map['end'] as String),
      repeat: Duration(minutes: map['repeat'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['title'] = title;
    map['description'] = description;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    map['repeat'] = repeat.inMinutes;
    return map;
  }

  Event setId(int id) {
    this.id = id;
    return this;
  }
}
