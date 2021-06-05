import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/model/alarm.model.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/utils/datetime.util.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final CalendarBloc _calendarBloc;

  // _startDate = _showEvent?.start ?? calendarooState.state.calendarState.selectedDay; TODO
  // _startTime = _showEvent?.start ?? defaultTime; TODO
  // _endDate = _showEvent?.end ?? _startDate; TODO
  // _endTime = setEndTime(defaultTime); TODO

  DetailsBloc(this._calendarBloc, {CalendarItemModel calendarItemModel})
      : super(DetailsState(
            calendarItemId: calendarItemModel?.id,
            title: calendarItemModel?.title ?? '',
            description: calendarItemModel?.description ?? '',
            startDate: calendarItemModel?.start ?? DateTime.now(),
            // TODO: remove time
            startTime: calendarItemModel?.start ?? DateTime.now(),
            // TODO: remove date
            endDate: calendarItemModel?.end ?? DateTime.now(),
            // TODO: remove time
            endTime: calendarItemModel?.end ?? DateTime.now(),
            // TODO: remove date
            allDay: false,
            // TODO: handle allDay
            repeat: calendarItemModel?.repeat ?? Repeat.never,
            until: calendarItemModel?.until,
            alarms: [
              Alarm(1, DateTime.now().subtract(Duration(minutes: 15)), false)
            ],
            edited: false));

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is DetailsValuesChangedEvent) {
      yield state.copyWith(
        calendarItemId: event.calendarItemId,
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        startTime: event.startTime,
        endTime: event.endTime,
        allDay: event.allDay,
        repeat: event.repeat,
        until: event.until,
        edited: true,
      );
    }

    if (event is DetailsSaveEvent) {
      var calendarItem = CalendarItemModel(
        title: state.title,
        description: state.description,
        start: DateTimeUtil.mergeDateAndTime(state.startDate, state.startTime),
        end: DateTimeUtil.mergeDateAndTime(state.endDate, state.endTime),
        // TODO aggiungere allday
        repeat: state.repeat,
        until: state.until,
      );

      if (state.calendarItemId == null) {
        _calendarBloc.add(CalendarCreateEvent(calendarItem));
      } else {
        calendarItem.id = state.calendarItemId;
        _calendarBloc.add(CalendarUpdateEvent(calendarItem));
      }
    }

    if (event is DetailsDeleteEvent) {
      if (state.calendarItemId != null) {
        _calendarBloc.add(CalendarDeleteEvent(state.calendarItemId));
      }
    }
  }

  // TODO
  // DateTime setEndTime(DetailsState state, DateTime defaultTime) {
  //   var toRet =
  //       state.calendarItemId?.end ?? defaultTime.add(Duration(hours: 1));
  //   if (toRet.isBefore(state.startTime)) {
  //     toRet = CalendarUtils.removeDate(DateTime(2000, 1, 1, 23, 59));
  //   }
  //
  //   return toRet;
  // }

  @override
  void onTransition(Transition<DetailsEvent, DetailsState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
