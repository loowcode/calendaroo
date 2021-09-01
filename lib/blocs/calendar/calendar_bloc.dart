import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item_instance.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item_map.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';
import 'package:calendaroo/repositories/calendar/calendar_repeat.repository.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(
    this._calendarItemRepository,
    this._calendarItemRepeatRepository,
  ) : super(CalendarInitial(
          selectedDay: Date.convertToDate(DateTime.now()),
          startRange:
              Date.convertToDate(DateTime.now().subtract(Duration(days: 60))),
          endRange: Date.convertToDate(DateTime.now().add(Duration(days: 60))),
        ));

  final CalendarRepository _calendarItemRepository;
  final CalendarItemRepeatRepository _calendarItemRepeatRepository;

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is CalendarLoadEvent) {
      yield CalendarLoading.fromState(state);

      var calendarItemMap = await getCalendarItemInstances();
      yield CalendarLoaded(
        selectedDay: state.selectedDay,
        startRange: state.startRange,
        endRange: state.endRange,
        calendarItemMap: calendarItemMap,
      );
    }

    if (event is CalendarCreateEvent) {
      yield CalendarLoading.fromState(state);

      var calendarItem = CalendarItem(
        title: event.calendarItem.title,
        description: event.calendarItem.description,
        start: event.calendarItem.start,
        end: event.calendarItem.end,
      );

      var id = await _calendarItemRepository.add(calendarItem);
      var calendarItemRepeat = buildCalendarItemRepeat(id, event.calendarItem);
      await _calendarItemRepeatRepository.add(calendarItemRepeat);

      var calendarItemMap = await getCalendarItemInstances();
      yield CalendarLoaded(
        selectedDay: state.selectedDay,
        startRange: state.startRange,
        endRange: state.endRange,
        calendarItemMap: calendarItemMap,
      );
    }

    if (event is CalendarUpdateEvent) {
      yield CalendarLoading.fromState(state);

      // Update calendar item
      await _calendarItemRepository.update(event.calendarItem.toEntity());

      // TODO: handle repeat update
      // Delete old repeat
      var calendarItemRepeat = await _calendarItemRepeatRepository
          .findByCalendarItemId(event.calendarItem.id);
      await _calendarItemRepeatRepository.delete(calendarItemRepeat.id);

      // Add new repeat
      var newCalendarItemRepeat =
          buildCalendarItemRepeat(event.calendarItem.id, event.calendarItem);
      await _calendarItemRepeatRepository.add(newCalendarItemRepeat);

      var calendarItemMap = await getCalendarItemInstances();
      yield CalendarLoaded(
        selectedDay: state.selectedDay,
        startRange: state.startRange,
        endRange: state.endRange,
        calendarItemMap: calendarItemMap,
      );
    }

    if (event is CalendarDeleteEvent) {
      yield CalendarLoading.fromState(state);

      await _calendarItemRepository.delete(event.id);
      var calendarItemMap = await getCalendarItemInstances();
      yield CalendarLoaded(
        selectedDay: state.selectedDay,
        startRange: state.startRange,
        endRange: state.endRange,
        calendarItemMap: calendarItemMap,
      );
    }

    if (event is CalendarDaySelectedEvent) {
      if (state is CalendarLoaded) {
        yield CalendarLoaded(
          selectedDay: event.selectedDay,
          startRange: state.startRange,
          endRange: state.endRange,
          calendarItemMap: (state as CalendarLoaded).calendarItemMap,
        );
      }
    }
  }

  CalendarItemRepeat buildCalendarItemRepeat(
      int id, CalendarItemModel calendarItem) {
    var repeatType = calendarItem.repeat;

    String day, weekDay, week, month, year;

    switch (repeatType) {
      case Repeat.never:
        day = calendarItem.start.day.toString();
        month = calendarItem.start.month.toString();
        year = calendarItem.start.year.toString();
        weekDay = week = '*';
        break;

      case Repeat.daily:
        day = weekDay = week = month = year = '*';
        break;

      case Repeat.weekly:
        weekDay = calendarItem.start.weekday.toString();
        day = week = month = year = '*';
        break;

      case Repeat.monthly:
        day = calendarItem.start.day.toString();
        weekDay = week = month = year = '*';
        break;

      case Repeat.yearly:
        day = calendarItem.start.day.toString();
        month = calendarItem.start.month.toString();
        weekDay = week = year = '*';
        break;
    }

    return CalendarItemRepeat(
      calendarItemId: id,
      from: Date.convertToDate(calendarItem.start),
      until: calendarItem.until != null
          ? Date.convertToDate(calendarItem.until)
          : null,
      day: day,
      weekDay: weekDay,
      week: week,
      month: month,
      year: year,
    );
  }

  Future<CalendarItemMap> getCalendarItemInstances() async {
    var mappedInstances = SplayTreeMap<Date, List<int>>();
    var mappedItems = SplayTreeMap<int, CalendarItemModel>();
    var currentDate = state.startRange;

    while (currentDate.isBefore(state.endRange)) {
      final items = await _calendarItemRepository.findByDate(currentDate);

      if (items.isNotEmpty) {
        // Add items' id to mapped instances
        mappedInstances.putIfAbsent(
            currentDate, () => List.generate(items.length, (i) => items[i].id));

        // Update mapped calendar items with id
        items.forEach((item) async {
          if (!mappedItems.containsKey(item.id)) {
            var calendarItemRepeat = await _calendarItemRepeatRepository
                .findByCalendarItemId(item.id);

            mappedItems.putIfAbsent(
              item.id,
              () => CalendarItemModel(
                id: item.id,
                title: item.title,
                description: item.description,
                start: item.start,
                end: item.end,
                repeat: calendarItemRepeat.toRepeat(),
                until: null, // TODO: get until
              ),
            );
          }
        });
      }

      currentDate = Date.convertToDate(currentDate.add(Duration(days: 1)));
    }

    var calendarItemMap = CalendarItemMap(
      instances: mappedInstances,
      items: mappedItems,
    );

    return calendarItemMap;
  }

  @override
  void onTransition(Transition<CalendarEvent, CalendarState> transition) {
    super.onTransition(transition);
    print('${transition.currentState.runtimeType} >== ${transition.event.runtimeType} ===> ${transition.nextState.runtimeType}');
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
