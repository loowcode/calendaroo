import 'dart:collection';

import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/models/date.model.dart';

class CalendarItemMap {
  SplayTreeMap<Date, List<int>> instances;
  SplayTreeMap<int, CalendarItemModel> items;

  CalendarItemMap({this.instances, this.items});
}
