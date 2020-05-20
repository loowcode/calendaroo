import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/events.repository.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {

    if (action is AddEvent) {
      var id = await EventsRepository().insertEvent(action.event);
      action.event.setId(id);
    }
    if (action is RemoveEvent) {
      EventsRepository().deleteEvent(action.event.id);
    }

    if (action is OpenEvent) {
      NavigationService().navigateTo(SHOW_EVENT, arguments: action.event);
    }


    next(action);
  }
}
