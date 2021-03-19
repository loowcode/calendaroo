
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CardViewModel {
  final Function(int) openEvent;

  CardViewModel({this.openEvent});

  static CardViewModel fromStore(Store<AppState> store) {
    return CardViewModel(
      openEvent: (eventId) => store.dispatch(DoToEvent(OpenEvent, eventId)),
    );
  }
}
