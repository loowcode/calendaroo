import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/received-notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> scheduleNotification(Event event) async {
  var date = DateTime.now().add(Duration(seconds: 5));

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'event_notification', 'Notifiche evento', 'Mostra le notifiche evento',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(
      event.id, event.title, event.description, date, platformChannelSpecifics,
      androidAllowWhileIdle: true, payload: event.id.toString());
}

Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
