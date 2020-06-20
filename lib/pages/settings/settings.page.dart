import 'package:calendaroo/colors.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/pages/settings/settings.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:calendaroo/utils/notification.utils.dart';
import 'package:calendaroo/widgets/common/page-title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rxdart/rxdart.dart';

// TODO: Use Theme
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = SharedPreferenceService().enableNotifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, SettingsViewModel>(
        converter: (store) => SettingsViewModel.fromStore(store),
        builder: (context, store) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageTitle(AppLocalizations.of(context).settings),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNotificationSetting(),
                      _buildFeedbackButton(),
                    ],
                  ),
                ),
                _buildVersion(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).notifications,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  icon: Icons.done,
                  label: AppLocalizations.of(context).yes,
                  onTap: () {
                    _enableNotifications(true);
                    setState(() {
                      _notifications = true;
                    });
                  },
                  selected: _notifications),
              _buildButton(
                  icon: Icons.close,
                  label: AppLocalizations.of(context).no,
                  onTap: () {
                    _enableNotifications(false);

                    setState(() {
                      _notifications = false;
                    });
                  },
                  selected: !_notifications),
            ],
          )
        ],
      ),
    );
  }

  // TODO: make a common widget for button
  Widget _buildFeedbackButton() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).feedback,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          RaisedButton(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(AppLocalizations.of(context).sendFeedback),
            ),
            color: AppTheme.primaryTheme.buttonColor,
            textColor: AppTheme.primaryTheme.textTheme.button.color,
            onPressed: () {
              _launchEmailUrl();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              AppLocalizations.of(context).feedbackInfo,
              style: AppTheme.primaryTheme.textTheme.bodyText1.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).version + ' ' + Environment().version + '\n' + AppLocalizations.of(context).madeWithLove,
          style: AppTheme.primaryTheme.textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButton(
      {@required IconData icon,
      @required String label,
      @required VoidCallback onTap,
      @required bool selected}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: onTap,
        color: selected ? blue : Colors.white,
        textColor: selected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24.0,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _enableNotifications(bool enableNotifications) {
    if (enableNotifications) {
      SharedPreferenceService().setBool('enableNotifications', true);
      var today = Date.today();
      calendarooState.state.calendarState.eventMapped.forEach((key, value) {
        if (today.compareTo(key) <= 0) {
          value.forEach((element) {
            if (today.isBefore(element.start)) {
              scheduleNotification(element);
            }
          });
        }
      });
    } else {
      SharedPreferenceService().setBool('enableNotifications', false);
      cancelAllNotifications();
    }
  }

  void _launchEmailUrl() async {
    var url = 'mailto:loowcode@gmail.com?subject=Feedback';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showAlert(
        context: context,
        title: AppLocalizations.of(context).warning,
        body: AppLocalizations.of(context).warningNoEmailApp,
        barrierDismissible: true,
      );
    }
  }
}
