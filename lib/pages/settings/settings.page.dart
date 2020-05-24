import 'package:calendaroo/colors.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/pages/settings/settings.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/common/page-title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// TODO: Use Theme
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = false;

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
                PageTitle('Settings'),
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
                  'Notifications',
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
                  label: 'Yes',
                  onTap: () {
                    setState(() {
                      _notifications = true;
                    });
                  },
                  selected: _notifications),
              _buildButton(
                  icon: Icons.close,
                  label: 'No',
                  onTap: () {
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
                  'Feedback',
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
              child: Text('Send us an email'),
            ),
            color: AppTheme.primaryTheme.buttonColor,
            textColor: AppTheme.primaryTheme.textTheme.button.color,
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Every feedback is important to us!',
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
          'Version ' + Environment().version + '\nMade with ❤ by LoowCode',
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
        color: selected ? secondaryBlue : Colors.white,
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
}
