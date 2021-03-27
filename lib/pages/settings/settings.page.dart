import 'package:calendaroo/blocs/settings/settings_bloc.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/widgets/common/page_title.dart';
import 'package:calendaroo/widgets/settings/setting_feedback_button.widget.dart';
import 'package:calendaroo/widgets/settings/setting_notification_toggle.widget.dart';
import 'package:calendaroo/widgets/settings/setting_version_info.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageTitle(AppLocalizations.of(context).settings),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SettingNotificationToggle(),
                  SettingFeedbackButton(),
                ],
              ),
            ),
            SettingVersionInfo(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Load settings
    BlocProvider.of<SettingsBloc>(context).add(SettingsLoadEvent());
  }
}
