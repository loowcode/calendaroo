import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class ShowEventViewModel {
  final Event event;

  final Function(Event) editEvent;

  ShowEventViewModel({this.event, this.editEvent});

  static ShowEventViewModel fromStore(Store<AppState> store) {
    return ShowEventViewModel(
      event: store.state.calendarState.showEvent,
      editEvent: (event) => store.dispatch(new EditEvent(event)),
    );
  }
}
