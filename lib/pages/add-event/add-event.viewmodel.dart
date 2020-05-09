import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class AddEventViewModel {
  final DateTime selectedDay;

  final Function(Event) createEvent;

  AddEventViewModel({this.selectedDay, this.createEvent});

  static AddEventViewModel fromStore(Store<AppState> store) {
    return AddEventViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      createEvent: (newEvent) => store.dispatch(new AddEvent(newEvent)),
    );
  }
}
