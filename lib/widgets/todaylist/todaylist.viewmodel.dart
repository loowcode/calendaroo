import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class TodayListViewModel {
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;

  TodayListViewModel({this.eventMapped});

  static TodayListViewModel fromStore(Store<AppState> store) {
    return TodayListViewModel(
      eventMapped: store.state.calendarState.eventsMapped,
    );
  }
}
