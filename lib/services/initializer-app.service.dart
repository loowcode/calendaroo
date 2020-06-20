import 'package:calendaroo/constants.dart';
import 'package:calendaroo/dao/database.service.dart';
import 'package:calendaroo/dao/events.repository.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../utils/notification.utils.dart';
import 'local-storage.service.dart';

class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();

  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  Future<void> setUp(environment, version) async {
    WidgetsFlutterBinding.ensureInitialized();
    // sharedPref init
    await SharedPreferenceService().getSharedPreferencesInstance();

    // Environment init
    Environment().environment = environment as String;
    Environment().version = version as String;

    // loadData init
    await _preLoadingDataFromDB();

    // setup orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // init Notification
    await initNotification();
  }

  void _preLoadingDataFromDB() async {
    try {
      var env = Environment().environment;
      if (env == DEVELOP) {
        final clientDB = await LocalStorageService().db;
        await LocalStorageService().dropTable(clientDB);
        debugPrint('DB deleted');
      }
    } catch (e) {
      debugPrint('error during drop db: ${e.toString()}');
    }
    var eventsList = await DatabaseService().getEvents(Date.today());
    await DatabaseService().getEvents(Date.today());
    calendarooState.dispatch(LoadedEventsList(eventsList));
  }
}
