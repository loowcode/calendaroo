import 'package:calendaroo/dao/events.repository.dart';
import 'package:calendaroo/redux/actions/app-status.actions.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is StartApplication) {
      var eventsList = await EventsRepository().events();
      next(LoadedEventsList(eventsList));
    }
    next(action);
  }
}
