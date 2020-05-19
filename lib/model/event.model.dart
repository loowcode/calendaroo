import 'package:flutter/cupertino.dart';

class Event {
  int id;
  String title;
  String uuid;
  String description;
  DateTime start;
  DateTime end;

// TODO ...

  Event(
      {@required this.id,
      @required this.title,
      @required this.uuid,
      this.description,
      this.start,
      this.end});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['uuid'] = uuid;
    map['description'] = description;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    return map;
  }

  Event setId(int id) {
    this.id = id;
    return this;
  }
}
