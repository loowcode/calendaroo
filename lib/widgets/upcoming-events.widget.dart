import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    return StoreConnector<AppState, List<Event>>(
        converter: (store) => store.state.calendarState.events,
        builder: (context, events) {
          return Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: primaryWhite, borderRadius: radius),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: events
                        .map((elem) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.8),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(''),
                        onTap: () => print(' tapped!'),
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Container> _buildAgenda(List<Event> events) {
    List<Container> widgets = [];
    return widgets
      ..add(Container(child: Text(AppLocalizations.of(context).translate(Texts.UPCOMING_EVENTS))))
      ..addAll(events
          .map((elem) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(''),
                  onTap: () => print(' tapped!'),
                ),
              ))
          .toList());
  }
}
