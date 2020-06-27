import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class DetailsViewModel {
  final Event focusedEvent;
  final Function(Event) removeEvent;

  DetailsViewModel({this.focusedEvent, this.removeEvent});

  static DetailsViewModel fromStore(Store<AppState> store) {
    return DetailsViewModel(
        focusedEvent: store.state.calendarState.focusedEvent,
        removeEvent: (event) => store.dispatch(RemoveEvent(event)));
  }
}
