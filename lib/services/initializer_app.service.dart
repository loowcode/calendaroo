import 'package:calendaroo/constants.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/services/shared_preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

import 'local_storage.service.dart';

class InitializerAppService {
  static final InitializerAppService _instance = InitializerAppService._();

  InitializerAppService._();

  factory InitializerAppService() {
    return _instance;
  }

  Future<void> setUp(String env) async {
    WidgetsFlutterBinding.ensureInitialized();

    await SharedPreferenceService().getSharedPreferencesInstance();

    var packageInfo = await PackageInfo.fromPlatform();
    Environment().environment = env;
    Environment().version = packageInfo.version;

    try {
      if (env == DEVELOP) {
        final clientDB = await LocalStorageService().db;
        await LocalStorageService().dropTable(clientDB);
        debugPrint('DB deleted');
      }
    } catch (e) {
      debugPrint('error during drop db: ${e.toString()}');
    }
  }

// Future<List<Event>> setUp(String environment, String version) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // sharedPref init
//   await SharedPreferenceService().getSharedPreferencesInstance();
//
//   // Environment init
//   Environment().environment = environment;
//   Environment().version = version;
//
//   // loadData init
//   var eventsList = await preLoadingDataFromDB();
//
//   // setup orientation
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//
//   // init Notification
//   await initNotification();
//
//   return eventsList;
// }
//
// static Future<List<Event>> preLoadingDataFromDB() async {
//   try {
//     var env = Environment().environment;
//     if (env == DEVELOP) {
//       final clientDB = await LocalStorageService().db;
//       await LocalStorageService().dropTable(clientDB);
//       debugPrint('DB deleted');
//     }
//   } catch (e) {
//     debugPrint('error during drop db: ${e.toString()}');
//   }
//   var rangeStart =
//       Date.convertToDate(DateTime.now().subtract(Duration(days: 60)));
//   var rangeEnd = Date.convertToDate(DateTime.now().add(Duration(days: 60)));
//   var eventsList = await DatabaseService().getEvents(rangeStart, rangeEnd);
//   calendarooState.dispatch(LoadedEventsList(eventsList));
//   return eventsList;
// }
}
