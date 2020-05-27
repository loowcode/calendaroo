import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class ShowEventViewModel {
  final Event showEvent;


  ShowEventViewModel({this.showEvent});

  static ShowEventViewModel fromStore(Store<AppState> store) {
    return ShowEventViewModel(
      showEvent: store.state.calendarState.showEvent,
    );
  }
}
