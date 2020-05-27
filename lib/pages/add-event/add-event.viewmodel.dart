import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class AddEventViewModel {
  final DateTime selectedDay;

  final Function(Event) createEvent;
  final Function(Event, Event) editEvent;

  AddEventViewModel({this.selectedDay, this.createEvent, this.editEvent});

  static AddEventViewModel fromStore(Store<AppState> store) {
    return AddEventViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      createEvent: (newEvent) => store.dispatch(new AddEvent(newEvent)),
      editEvent: (oldEvent, newEvent) => store.dispatch(new EditEvent(oldEvent, newEvent)),
    );
  }
}
