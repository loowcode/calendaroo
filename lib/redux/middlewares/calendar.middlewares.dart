import 'package:calendaroo/model/mocks/eventsList.mock.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is FetchEventsList) {
//      if (await sharedPreferenceService.environment == 'develop') {
//        next(LoadedEventsList(eventsListMock));
//      }
    }
    next(action);
  }
}
