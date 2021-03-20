import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class DetailsViewModel {
  final Event focusedEvent;

  final Function(Event) createEvent;
  final Function(Event) editEvent;
  final Function() deleteEvent;

  DetailsViewModel(
      {this.focusedEvent, this.createEvent, this.editEvent, this.deleteEvent});

  static DetailsViewModel fromStore(Store<AppState> store) {
    return DetailsViewModel(
        focusedEvent: store.state.calendarState.focusedEvent,
        createEvent: (newEvent) => store.dispatch(AddEvent(newEvent)),
        editEvent: (newEvent) => store.dispatch(EditEvent(newEvent)),
        deleteEvent: () => store
            .dispatch(RemoveEvent(store.state.calendarState.focusedEvent)));
  }
}
