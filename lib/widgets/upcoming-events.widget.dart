import 'package:calendaroo/colors.dart';
import 'package:calendaroo/services/appLocalizations.dart';
import 'package:flutter/material.dart';

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topRight: Radius.circular(128.0),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [secondaryBlue, accentYellow],
              stops: [0.0, 2.0],
            ),
            borderRadius: radius),
        child: ListView(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('upcoming-events')),
            Container(child: Text('evento'))
          ],
        ),
      ),
    );
  }
}
