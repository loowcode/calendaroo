import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class NewEventViewModel {
  final Event newEvent;

  final Function(Event) createEvent;

  NewEventViewModel({this.newEvent, this.createEvent});

  static NewEventViewModel fromStore(Store<AppState> store) {
    return NewEventViewModel(
      newEvent: store.state.calendarState.newEventCached,
      createEvent: (newEvent) => store.dispatch(new AddEvent(newEvent)),
    );
  }
}
