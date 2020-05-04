import 'package:flutter/cupertino.dart';

class Event {
  String id;
  String title;
  String description;
  DateTime start;
  DateTime finish;
// TODO ...

  Event(
      {@required this.id,
      @required this.title,
      this.description,
      this.start,
      this.finish});


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['start'] = start;
    map['finish'] = finish;
    return map;
  }

}
