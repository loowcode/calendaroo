import 'package:calendaroo/dao/database.service.dart';
import 'package:calendaroo/dao/events.repository.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:calendaroo/utils/notification.utils.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AddEvent) {
      var id = await DatabaseService().saveEvent(action.event);
      action.event.setId(id);

      if (SharedPreferenceService().enableNotifications) {
        scheduleNotification(action.event);
      }
    }

    if (action is RemoveEvent) {
      EventsRepository().deleteEvent(action.event.id);
      cancelNotification(action.event.id);
    }

    if (action is OpenEvent) {
      if (action.event != null) {
        NavigationService().navigateTo(SHOW_EVENT, arguments: action.event);
      }
    }

    next(action);
  }
}


