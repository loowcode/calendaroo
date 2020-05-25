import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/events.repository.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'notification.utils.dart';

class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();

  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  Future<void> setUp(environment, version) async {
    WidgetsFlutterBinding.ensureInitialized();
    // sharedPref init
    SharedPreferenceService().getSharedPreferencesInstance();

    // Environment init
    Environment().environment = environment;
    Environment().version = version;

    // loadData init
    await _preLoadingDataFromDB();

    // setup orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // init Notification
    initNotification();
  }

  _preLoadingDataFromDB() async {
    var eventsList = await EventsRepository().events();
    calendarooState.dispatch(LoadedEventsList(eventsList));
  }
}
