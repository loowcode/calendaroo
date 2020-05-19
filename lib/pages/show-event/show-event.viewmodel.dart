import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class ShowEventViewModel {
  final Event showEvent;

  final Function(Event, Event) editEvent;

  ShowEventViewModel({this.showEvent, this.editEvent});

  static ShowEventViewModel fromStore(Store<AppState> store) {
    return ShowEventViewModel(
      showEvent: store.state.calendarState.showEvent,
      editEvent: (oldEvent, newEvent) =>
          store.dispatch(new EditEvent(oldEvent, newEvent)),
    );
  }
}
