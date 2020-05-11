import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';

import 'local-storage.service.dart';

class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();
  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  preLoadingData() async {
    var eventsList = await LocalStorageService().events();
    calendarooState.dispatch(LoadedEventsList(eventsList));
  }
}
