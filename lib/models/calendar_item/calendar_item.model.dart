import 'package:calendaroo/model/repeat.model.dart';

class CalendarItemModel {
  int id;
  String title;
  String description;
  DateTime start;
  DateTime end;
  // bool allDay;
  Repeat repeat;
  // DateTime until;

  CalendarItemModel({
    this.id, // era required
    this.title,
    this.description,
    this.start,
    this.end,
    // this.allDay,
    this.repeat,
    // this.until,
  });

  factory CalendarItemModel.fromMap(Map<String, dynamic> map) {
    return CalendarItemModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      start: DateTime.parse(map['start'] as String),
      end: DateTime.parse(map['end'] as String),
      // allDay: (map['allDay'] as int) == 1 ? true : false,
      repeat: Repeat.fromJson(map['repeat'] as String),
      // until: DateTime.parse(map['until'] as String ?? map['start'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['start'] = start.toIso8601String();
    map['end'] = end.toIso8601String();
    // map['allDay'] = allDay ? 1 : 0;
    map['repeat'] = repeat.toJson();
    // map['until'] = until?.toIso8601String();
    return map;
  }

  CalendarItemModel setId(int id) {
    this.id = id;
    return this;
  }
}
