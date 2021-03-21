import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/models/calendar_item.model.dart';
import 'package:equatable/equatable.dart';

part 'today_event.dart';
part 'today_state.dart';

class TodayBloc extends Bloc<TodayEvent, TodayState> {

  TodayBloc() : super(TodayInitial());

  @override
  Stream<TodayState> mapEventToState(
    TodayEvent event,
  ) async* {
      // TODO
  }
}
