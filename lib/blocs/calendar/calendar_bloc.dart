import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item_instance.model.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(this._repository) : super(CalendarInitial());

  final CalendarRepository _repository;

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is CalendarLoadEvent) {
      yield CalendarLoading(); // TODO
      var mappedItems = await getCalendarItemInstances();
      yield CalendarLoaded(
        mappedCalendarItems: mappedItems,
        selectedDay: Date.today(),
      );
    }

    if (event is CalendarCreateEvent) {
      yield CalendarLoading(); // TODO
      print(await _repository.add(event.calendarItem));
      var mappedItems = await getCalendarItemInstances();
      yield CalendarLoaded(
        mappedCalendarItems: mappedItems,
        selectedDay: Date.today(),
      );
    }

    if (event is CalendarUpdateEvent) {
      yield CalendarLoading();
      await _repository.update(event.calendarItem);
      var mappedItems = await getCalendarItemInstances();
      yield CalendarLoaded(
        mappedCalendarItems: mappedItems,
        selectedDay: Date.today(),
      );
    }

    if (event is CalendarDeleteEvent) {
      yield CalendarLoading(); // TODO
      await _repository.delete(event.id);
      var mappedItems = await getCalendarItemInstances();
      yield CalendarLoaded(
        mappedCalendarItems: mappedItems,
        selectedDay: Date.today(),
      );
    }
  }

  Future<SplayTreeMap<Date, List<CalendarItemInstance>>>
      getCalendarItemInstances() async {
    final items = await _repository.findAll();
    final mappedItems = _generateInstances(items);
    return mappedItems;
  }

  @override
  void onTransition(Transition<CalendarEvent, CalendarState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  SplayTreeMap<Date, List<CalendarItemInstance>> _generateInstances(
      List<CalendarItem> items) {
    var map = SplayTreeMap<Date, List<CalendarItemInstance>>();
    // items.forEach((CalendarItem item) {
    //   createInstance(item).forEach((elem) {
    //     var first = Date.convertToDate(elem.start);
    //     var index = Date.convertToDate(elem.start);
    //     var last = Date.convertToDate(elem.end);
    //     for (var i = 0; i <= first.difference(last).inDays; i++) {
    //       _insertIntoMap(map, index, elem);
    //       index = Date.convertToDate(index.add(Duration(days: 1)));
    //     }
    //   });
    // });

    return map;
  }

  static void _insertIntoMap(SplayTreeMap<Date, List<CalendarItemInstance>> map,
      Date date, CalendarItemInstance event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
      list.sort((a, b) => a.start.isBefore(b.start) ? 1 : 0);
      map[date] = list;
    } else {
      map.putIfAbsent(date, () => [event]);
    }
  }

  static List<CalendarItemInstance> createInstance(CalendarItem item) {
    var instances = <CalendarItemInstance>[];
    var _uuid = Uuid();
    var first = CalendarUtils.removeTime(item.start);
    var index = CalendarUtils.removeTime(item.start);
    var last = CalendarUtils.removeTime(item.end);

    var daySpan = last.difference(first).inDays;
    for (var i = 0; i <= daySpan; i++) {
      var instance = CalendarItemInstance(
        id: null,
        uuid: _uuid.v4(),
        eventId: item.id,
        title: item.title,
        start: DateTime(
          index.year,
          index.month,
          index.day,
          i == 0 ? item.start.hour : 0,
          i == 0 ? item.start.minute : 0,
        ),
        end: DateTime(
          index.year,
          index.month,
          index.day,
          i == daySpan ? item.end.hour : 23,
          i == daySpan ? item.end.minute : 59,
        ),
      );
      instances.add(instance);
      index = index.add(Duration(days: 1));
    }
    return instances;
  }

  @override
  void onEvent(CalendarEvent event) {
    super.onEvent(event);
    print(event);
  }
}
