import 'package:flutter/cupertino.dart';

class EventInstance {
  int parentId;
  String uuid;
  String title;
  String description;
  DateTime start;
  DateTime end;

  EventInstance(
      {@required this.parentId,
      @required this.uuid,
      this.title,
      this.description,
      this.start,
      this.end});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['parentId'] = parentId;
    map['uuid'] = uuid;
    map['title'] = title;
    map['description'] = description;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    return map;
  }
}
