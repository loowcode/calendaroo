import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:calendaroo/widgets/upcoming-events/upcoming-events.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';


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
    return StoreConnector<AppState, UpcomingEventsViewModel>(
        converter: (store) => UpcomingEventsViewModel.fromStore(store),
        builder: (context, store) {
          return Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: primaryWhite, borderRadius: radius),
              child: Stack(
                children: <Widget>[
                  ListView(children: _buildAgenda(store.events)),
                ],
              ),
            ),
          );
        });
  }

  List<Container> _buildAgenda(List<Event> events) {
    Map<DateTime, List<Event>> mapEvent = calendarService.toMap(events);
    List<Container> widgets = [];
    var formatter =
        DateFormat.MMMMEEEEd(AppLocalizations.of(context).locale.toString());
    mapEvent.forEach((date, list) {
      widgets
        ..add(Container(child: Text(formatter.format(date))))
        ..addAll(events
            .map((elem) => Container(
                  child: Card(
                    child: ListTile(
                      title: Text(elem.title==null?'':elem.title),
                    ),
                  ),
                ))
            .toList());
    });
    return widgets;
  }
}
