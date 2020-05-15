import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:calendaroo/services/local-storage.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/upcoming-events/upcoming-events.widget.dart';
import 'package:redux/redux.dart';

class CalendarMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AddEvent) {
      var id = await LocalStorageService().insertEvent(action.event);
      action.event.setId(id);
    }
    if (action is RemoveEvent) {
      LocalStorageService().deleteEvent(action.event.id);
    }

    if (action is OpenEvent) {
      NavigationService().navigateTo(SHOW_EVENT, arguments: action.event);
    }

    if (action is SelectDay) {
      // TODO animationController with redux
//      calendarController.setSelectedDay(action.day);
//      if (listController != null) {
//        try {
//          listController.scrollToIndex(calendarService.getIndex(
//              store.state.calendarState.eventMapped, action.day));
////          animationController.forward(from: 0);
//        } catch (e) {
//          print('no events for selected day');
//        }
//      }
    }

    next(action);
  }
}
