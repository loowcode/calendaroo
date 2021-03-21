import 'package:calendaroo/blocs/settings/settings_bloc.dart';
import 'package:calendaroo/colors.dart';
import 'package:calendaroo/models/settings/settings.model.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingNotificationToggle extends StatefulWidget {
  @override
  _SettingNotificationToggleState createState() =>
      _SettingNotificationToggleState();
}

class _SettingNotificationToggleState extends State<SettingNotificationToggle> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        var bloc = BlocProvider.of<SettingsBloc>(context);

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
                        bloc.add(SettingsChangedEvent(Settings(true)));
                      },
                      selected: state is SettingsUpdated
                          ? state.values.notificationsEnabled
                          : false),
                  _buildButton(
                      icon: Icons.close,
                      label: AppLocalizations.of(context).no,
                      onTap: () {
                        bloc.add(SettingsChangedEvent(Settings(false)));
                      },
                      selected: state is SettingsUpdated
                          ? !state.values.notificationsEnabled
                          : false),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(
      {@required IconData icon,
      @required String label,
      @required VoidCallback onTap,
      @required bool selected}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: selected ? blue : Colors.white,
          onPrimary: selected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
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
