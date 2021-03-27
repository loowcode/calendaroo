import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'file:///C:/Users/jack1/OneDrive/Desktop/git/calendaroo/lib/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  // _showEvent = widget.calendarItem; TODO
  // _title = _showEvent?.title ?? '';
  // _description = _showEvent?.description ?? '';
  // _startDate = _showEvent?.start ?? calendarooState.state.calendarState.selectedDay; TODO
  // _startTime = _showEvent?.start ?? defaultTime;
  // _endDate = _showEvent?.end ?? _startDate;
  // _endTime = setEndTime(defaultTime); TODO

  // _allDay = _showEvent?.allDay ?? false;
  // _repeat = _showEvent?.repeat ?? Repeat(type: RepeatType.never);
  // _alarms = [Alarm(1, _startDate.subtract(Duration(minutes: 15)), false)];

  // _edited = false;

  DetailsBloc()
      : super(DetailsState(
          title: '',
          description: '',
          startDate: DateTime.now(),
          startTime: DateTime.now(),
          endDate: DateTime.now(),
          endTime: DateTime.now(),
          allDay: false,
          repeat: Repeat(type: RepeatType.never),
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
  }

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
