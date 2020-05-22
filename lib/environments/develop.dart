import 'package:calendaroo/constants.dart';
import 'package:calendaroo/main.dart';
import 'package:calendaroo/model/received-notification.dart';
import 'package:calendaroo/pages/home.page.dart';
import 'package:calendaroo/services/initializer-app.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'environment.dart';

// TODO: main have too much work and some frames are skipped
void main() async {
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService().getSharedPreferencesInstance();
  Environment().environment = DEVELOP;
  Environment().version = VERSION;
  InitializerAppService().preLoadingData();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // TODO: too much duplicated code! develop and integration are very similar
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
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
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
}
