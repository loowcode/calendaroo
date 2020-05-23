import 'package:calendaroo/colors.dart';
import 'package:calendaroo/pages/settings/settings.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/common/page-title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      _buildFeedbackSetting(),
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
                  icon: Icons.done, label: 'Yes', onTap: () => print('Yes')),
              _buildButton(
                  icon: Icons.close, label: 'No', onTap: () => print('No'))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeedbackSetting() {
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
                  'Feedbacks',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  icon: Icons.done, label: 'Yes', onTap: () => print('Yes')),
              _buildButton(
                  icon: Icons.close, label: 'No', onTap: () => print('No'))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Version 0.1 - Made with ❤ by LoowCode', style: AppTheme.primaryTheme.textTheme.caption,),
      ],
    );
  }

  Widget _buildButton(
      {@required IconData icon,
      @required String label,
      @required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 1),
                blurRadius: 8.0,
                spreadRadius: 0,
              )
            ],
          ),
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
