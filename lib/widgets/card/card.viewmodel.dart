import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CardViewModel {
  final Function(int) openEvent;

  CardViewModel({this.openEvent});

  static CardViewModel fromStore(Store<AppState> store) {
    return CardViewModel(
      openEvent: (eventId) => store.dispatch(OpenEvent(eventId)),
    );
  }
}
