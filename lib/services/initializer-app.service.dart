import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/events.repository.dart';


class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();
  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  preLoadingData() async {
    var eventsList = await EventsRepository().events();
    calendarooState.dispatch(LoadedEventsList(eventsList));
  }
}
