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

  DetailsBloc(this._calendarBloc)
      : super(DetailsState(
          title: '',
          description: '',
          startDate: DateTime.now(),
          startTime: DateTime.now(),
          endDate: DateTime.now(),
          endTime: DateTime.now(),
          allDay: false,
          repeat: Repeat(type: RepeatType.never),
          alarms: [
            Alarm(1, DateTime.now().subtract(Duration(minutes: 15)), false)
          ],
          edited: false,
        ));

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
          end: state.endDate,
          repeat: state.repeat,
        );

        _calendarBloc.add(CalendarCreateEvent(calendarItem));
      } else {
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
    super.onTransition(transition);
    print(transition);
  }
}
