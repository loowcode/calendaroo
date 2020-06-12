import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:redux/redux.dart';

class ShowEventViewModel {
  final Event showEvent;
  final Function(Event) removeEvent;
  ShowEventViewModel({this.showEvent, this.removeEvent});

  static ShowEventViewModel fromStore(Store<AppState> store) {
    return ShowEventViewModel(
      showEvent: store.state.calendarState.showEvent,
      removeEvent: (event) => store.dispatch( RemoveEvent(event))
    );
  }
}
