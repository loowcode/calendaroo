import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/model/repeat.model.dart';

class CalendarItemModel {
  int id;
  String title;
  String description;
  DateTime start;
  DateTime end;
  // bool allDay;
  Repeat repeat;
  DateTime until;

  CalendarItemModel({
    this.id, // era required
    this.title,
    this.description,
    this.start,
    this.end,
    // this.allDay,
    this.repeat,
    this.until,
  });

  factory CalendarItemModel.fromEntity(CalendarItem entity) {
    return CalendarItemModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      start: entity.start,
      end: entity.end,
      // allDay: (map['allDay'] as int) == 1 ? true : false,
      repeat: Repeat(type: RepeatType.never),
      // TODO: get repeat
      until: null, // TODO: get until
    );
  }

  CalendarItem toEntity() {
    var entity = CalendarItem(
        id: id, title: title, description: description, start: start, end: end);

    return entity;
  }
}
