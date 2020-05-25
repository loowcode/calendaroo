import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/received-notification.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/events.repository.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../routes.dart';
import 'navigation.service.dart';
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
    _initNotification();
  }

  Future _initNotification() async {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = AndroidInitializationSettings(
        'notification_icon'); // android/app/src/main/res/drawable/notification_icon.png
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      Event event = await EventsRepository().event(int.parse(payload));
      NavigationService().navigateTo(SHOW_EVENT, arguments: event);
    }
    selectNotificationSubject.add(payload);
  }

  _preLoadingDataFromDB() async {
    var eventsList = await EventsRepository().events();
    calendarooState.dispatch(LoadedEventsList(eventsList));
  }
}
