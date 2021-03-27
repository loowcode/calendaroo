import 'file:///C:/Users/jack1/OneDrive/Desktop/git/calendaroo/lib/models/calendar_item/calendar_item_instance.model.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/widgets/card/card.viewmodel.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../options.widget.dart';

class CardWidget extends StatefulWidget {
  final CalendarItemInstance event;

  CardWidget(this.event);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());
    return StoreConnector<AppState, CardViewModel>(
        converter: (store) => CardViewModel.fromStore(store),
        builder: (context, store) {
          return GestureDetector(
            onTap: () {
              store.openEvent(widget.event.eventId);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: SizedBox(
                height: 68,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: blueGradient)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FeatherIcons.calendar,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.event.title != null &&
                                    widget.event.title.isNotEmpty
                                ? widget.event.title
                                : '(no title)',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                              '${formatterTime.format(widget.event.start)} - ${formatterTime.format(widget.event.end)}',
                              style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                    ),
                    PopupMenuButton<Option>(
                      onSelected: selectOption,
                      color: white,
                      icon: Icon(
                        Icons.more_vert,
                        color: grey,
                      ),
                      itemBuilder: (BuildContext context) {
                        return options.map((Option option) {
                          return PopupMenuItem<Option>(
                            value: option.setEvent(widget.event.eventId),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(cardColor: white),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate(option.title),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: black),
                                )),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
