import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class SettingVersionInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _buildVersionInfoText(context),
          style: AppTheme.primaryTheme.textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _buildVersionInfoText(BuildContext context) {
    return AppLocalizations.of(context).version +
        ' ' +
        Environment().version +
        '\n' +
        AppLocalizations.of(context).madeWithLove;
  }
}
