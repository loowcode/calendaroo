import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/repositories/calendar/calendar_local.repository.dart';
import 'package:calendaroo/repositories/calendar/calendar_repeat_local.repository.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/utils/notification.utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'dao/events.repository.dart';
import 'environments/integration.dart' as env;
import 'model/received-notification.dart';

void main() {
  env.main();
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _requestIOSPermissions();
      _configureDidReceiveLocalNotificationSubject();
      _configureSelectNotificationSubject();
    });
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // TODO: migrate to bloc
  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog<Widget>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                var event = await EventsRepository()
                    .event(int.parse(receivedNotification.payload));
                // calendarooState.dispatch(OpenEvent(event));
                await NavigationService().navigateTo(DETAILS, arguments: event);
              },
              child: Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  // TODO: migrate to bloc
  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      var event = await EventsRepository().event(int.parse(payload));
      // calendarooState.dispatch(OpenEvent(event));
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(
        CalendarLocalRepository(),
        CalendarItemRepeatLocalRepository(),
      ),
      child: MaterialApp(
        title: 'Calendaroo',
        supportedLocales: [
          Locale('en', 'EN'),
          Locale('it', 'IT'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        theme: AppTheme.primaryTheme,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: HOMEPAGE,
        onGenerateRoute: routes,
      ),
    );
  }
}
