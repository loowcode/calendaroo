import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

import 'local-storage.service.dart';

class InitializerAppService {
  preLoadingData(Store<AppState> store) async {
    var eventsList = await LocalStorageService().events();
    store.dispatch(LoadedEventsList(eventsList));
  }
}

InitializerAppService initializerAppService = InitializerAppService();
