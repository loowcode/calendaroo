import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/local-storage.service.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AddEvent) {
      LocalStorageService().insertEvent(action.event);
    }
    next(action);
  }
}
