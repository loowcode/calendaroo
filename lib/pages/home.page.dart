import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/received-notification.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.secondaryTheme,
      child: Scaffold(
        body: Column(
            children: [Expanded(child: CalendarWidget()), _buildBottomBar()]),
      ),
    );
  }

  _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(color: backgroundWhite),
      child: SizedBox(
        height: 64,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomIcon(Icons.add, "Add Event",
                  () => NavigationService().navigateTo(ADD_EVENT)),
              _buildBottomIcon(
                  Icons.today,
                  AppLocalizations.of(context).translate('today'),
                  () => calendarooState.dispatch(SelectDay(DateTime.now()))),
              _buildBottomIcon(Icons.account_circle, "Account", () {}),
              _buildBottomIcon(Icons.notifications, "Notifica", () async {
                var androidPlatformChannelSpecifics =
                    AndroidNotificationDetails('your channel id',
                        'your channel name', 'your channel description',
                        importance: Importance.Max,
                        priority: Priority.High,
                        ticker: 'ticker');
                var iOSPlatformChannelSpecifics = IOSNotificationDetails();
                var platformChannelSpecifics = NotificationDetails(
                    androidPlatformChannelSpecifics,
                    iOSPlatformChannelSpecifics);
                await flutterLocalNotificationsPlugin.show(
                    0, 'plain title', 'plain body', platformChannelSpecifics,
                    payload: 'item x');
              }),
            ]),
      ),
    );
  }

  Material _buildBottomIcon(icon, text, onSelect) {
    return Material(
      shape: CircleBorder(),
      color: backgroundWhite, // button color
      child: InkWell(
        radius: 64,
        customBorder: CircleBorder(),
        child: SizedBox(
          height: 64,
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: secondaryGrey,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: secondaryGrey),
              )
            ],
          ),
        ),
        onTap: onSelect,
      ),
    );
  }
}
