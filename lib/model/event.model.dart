import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'alarm.model.dart';

class Event {
  int id;
  String uuid;
  String title;
  String description;
  DateTime start;
  DateTime end;
  bool allDay;
  Duration repeat;
  DateTime until;
  List<Alarm> alarms;

  Event(
      {@required this.id,
      @required this.uuid,
      this.title,
      this.description,
      this.start,
      this.end,
      this.allDay,
      this.repeat,
      this.until,
      this.alarms
      });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int,
      title: map['title'] as String,
      uuid: map['uuid'] as String,
      description: map['description'] as String,
      start: DateTime.parse(map['start'] as String),
      end: DateTime.parse(map['end'] as String),
      allDay: map['repeat'] as bool,
      repeat: Duration(minutes: map['repeat'] as int ?? 0),
      until: DateTime.parse(map['until'] as String ?? map['start'] as String),
      alarms: ((jsonDecode(map['alarms'] as String) as List)??[]).map((e) => Alarm.fromJson(e)).toList(),
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
    map['allDay'] = allDay;
    map['repeat'] = repeat?.inMinutes;
    map['until'] = until?.toIso8601String();
    map['alarms'] = jsonEncode(alarms);
    return map;
  }

  Event setId(int id) {
    this.id = id;
    return this;
  }

}
