import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/model/alarm.model.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final CalendarBloc _calendarBloc;

  // _showEvent = widget.calendarItem; TODO
  // _title = _showEvent?.title ?? ''; TODO
  // _description = _showEvent?.description ?? ''; TODO
  // _startDate = _showEvent?.start ?? calendarooState.state.calendarState.selectedDay; TODO
  // _startTime = _showEvent?.start ?? defaultTime; TODO
  // _endDate = _showEvent?.end ?? _startDate; TODO
  // _endTime = setEndTime(defaultTime); TODO
  // _allDay = _showEvent?.allDay ?? false; TODO
  // _repeat = _showEvent?.repeat ?? Repeat(type: RepeatType.never); TODO

  DetailsBloc(this._calendarBloc, {CalendarItemModel calendarItemModel})
      : super(DetailsState(
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
            repeat: calendarItemModel?.repeat ?? Repeat(type: RepeatType.never),
            until: calendarItemModel?.until,
            alarms: [
              Alarm(1, DateTime.now().subtract(Duration(minutes: 15)), false)
            ],
            edited: false,
            calendarItem: calendarItemModel));

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is DetailsValuesChangedEvent) {
      yield state.copyWith(
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        startTime: event.startTime,
        endTime: event.endTime,
        allDay: event.allDay,
        repeat: event.repeat,
        until: event.until,
        calendarItem: event.calendarItem,
        edited: true,
      );
    }

    if (event is DetailsSaveEvent) {
      if (state.calendarItem == null) {
        var calendarItem = CalendarItemModel(
          title: state.title,
          description: state.description,
          start: state.startDate,
          //TODO manca il time
          end: state.endDate,
          // TODO manca il time
          // TODO aggiungere allday
          repeat: state.repeat,
          until: state.until,
        );

        _calendarBloc.add(CalendarCreateEvent(calendarItem));
      } else {
        // TODO: improve this update. Can we store only calendar item id and
        // create a new instance here only when it's needed?
        state.calendarItem.title = state.title;
        state.calendarItem.description = state.description;
        state.calendarItem.start = state.startDate; // TODO: add time
        state.calendarItem.end = state.endDate; // TODO: add time
        state.calendarItem.repeat = state.repeat;
        state.calendarItem.until = state.until;
        _calendarBloc.add(CalendarUpdateEvent(state.calendarItem));
      }
    }

    if (event is DetailsDeleteEvent) {
      if (state.calendarItem != null) {
        _calendarBloc.add(CalendarDeleteEvent(state.calendarItem.id));
      }
    }
  }

  // TODO
  DateTime setEndTime(DetailsState state, DateTime defaultTime) {
    var toRet = state.calendarItem?.end ?? defaultTime.add(Duration(hours: 1));
    if (toRet.isBefore(state.startTime)) {
      toRet = CalendarUtils.removeDate(DateTime(2000, 1, 1, 23, 59));
    }

    return toRet;
  }

  @override
  void onTransition(Transition<DetailsEvent, DetailsState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
