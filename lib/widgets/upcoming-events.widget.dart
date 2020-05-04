import 'package:calendaroo/colors.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );
    return Expanded(
      child: Theme(
        data: AppTheme.primaryTheme,
        child: Container(
          decoration: BoxDecoration(
              color: primaryWhite,
              borderRadius: radius),
          child: ListView(
            children: <Widget>[
              Text(AppLocalizations.of(context).translate(Texts.UPCOMING_EVENTS)),
              Container(child: Text('evento'))
            ],
          ),
        ),
      ),
    );
  }
}
