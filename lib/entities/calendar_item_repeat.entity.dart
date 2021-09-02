import 'package:calendaroo/model/repeat.model.dart';

class CalendarItemRepeat {
  int id;
  int calendarItemId;
  DateTime from;
  DateTime until;
  String day;
  String weekDay;
  String week;
  String month;
  String year;

  CalendarItemRepeat({
    this.id,
    this.calendarItemId,
    this.from,
    this.until,
    this.day,
    this.weekDay,
    this.week,
    this.month,
    this.year,
  });

  factory CalendarItemRepeat.fromMap(Map<String, dynamic> map) {
    return CalendarItemRepeat(
      id: map['id'] as int,
      calendarItemId: map['calendar_item_id'] as int,
      from: DateTime.parse(map['repeat_from'] as String),
      until: map['repeat_until'] != null
          ? DateTime.parse(map['repeat_until'] as String)
          : null,
      day: map['repeat_day'] as String,
      weekDay: map['repeat_weekday'] as String,
      week: map['repeat_week'] as String,
      month: map['repeat_month'] as String,
      year: map['repeat_year'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['calendar_item_id'] = calendarItemId;
    map['repeat_from'] = from?.toIso8601String();
    map['repeat_until'] = until?.toIso8601String();
    map['repeat_day'] = day;
    map['repeat_weekday'] = weekDay;
    map['repeat_week'] = week;
    map['repeat_month'] = month;
    map['repeat_year'] = year;

    return map;
  }

  Repeat toRepeat() {
    var day = this.day != '*';
    var week = this.week != '*';
    var weekDay = this.weekDay != '*';
    var month = this.month != '*';
    var year = this.year != '*';

    if (day && month && year) {
      return Repeat.never;
    }

    if (!day && !week && !weekDay && !month && !year) {
      return Repeat.daily;
    }

    if (weekDay) {
      return Repeat.weekly;
    }

    if (day) {
      return Repeat.monthly;
    }

    if (day && month) {
      return Repeat.yearly;
    }

    return Repeat.never;
  }

  @override
  String toString() {
    return 'CalendarItemRepeat{id: $id, calendarItemId: $calendarItemId, from: $from, until: $until, day: $day, weekDay: $weekDay, week: $week, month: $month, year: $year}';
  }
}
