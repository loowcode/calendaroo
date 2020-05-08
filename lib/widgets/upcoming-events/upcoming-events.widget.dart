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
                  ListView(
                      padding: EdgeInsets.all(16),
                      children: _buildAgenda(store, store.events)),
                ],
              ),
            ),
          );
        });
  }

  List<Container> _buildAgenda(
      UpcomingEventsViewModel store, List<Event> events) {
    Map<DateTime, List<Event>> mapEvent = calendarService.toMap(events);
    List<Container> widgets = [];
    if (events == null || events.isEmpty) {
      return [
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            children: <Widget>[
              Text('Non ci sono eventi in programma',
                  style: Theme.of(context).textTheme.subtitle),
              Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Icon(
                    Icons.event_available,
                    size: 64,
                    color: secondaryLightGrey,
                  ))
            ],
          )),
        )
      ];
    }

    var formatterTime =
        DateFormat.Hm(AppLocalizations.of(context).locale.toString());
    var formatter =
        DateFormat.MMMMEEEEd(AppLocalizations.of(context).locale.toString());
    mapEvent.forEach((date, list) {
      widgets
        ..add(Container(
            child: Text(
          formatter.format(date),
          style: Theme.of(context).textTheme.headline,
        )))
        ..addAll(list
            .map((elem) => Container(
                  child: GestureDetector(
                    onTap: () {
                      store.openEvent(elem);
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(formatterTime.format(elem.start),
                                      style: Theme.of(context).textTheme.body1),
                                  Text(formatterTime.format(elem.end),
                                      style: Theme.of(context).textTheme.body1),
                                ],
                              ),
                              title: Text(
                                elem.title,
                                style: Theme.of(context).textTheme.body1,
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    print("more");
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    color: primaryWhite,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList());
    });
    return widgets;
  }
}
