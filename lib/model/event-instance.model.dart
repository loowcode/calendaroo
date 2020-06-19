import 'package:flutter/cupertino.dart';

class EventInstance {
  int id;
  String uuid;
  int eventId;
  DateTime start;
  DateTime end;

  EventInstance(
      {@required this.id,
      @required this.uuid,
      @required this.eventId,
      @required this.start,
      @required this.end});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['eventId'] = eventId;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    return map;
  }
}
