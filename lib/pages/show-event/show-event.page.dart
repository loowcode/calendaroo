import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/pages/show-event/show-event.viewmodel.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class ShowEventPage extends StatefulWidget {
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  @override
  void dispose() {
    calendarooState.dispatch(OpenEvent(null));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ShowEventViewModel>(
          converter: (store) => ShowEventViewModel.fromStore(store),
          builder: (context, store) {
            return _buildPage(store);
          }),
    );
  }

  Widget _buildPage(ShowEventViewModel store) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 200,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        floating: false,
        pinned: true,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: white),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: white,
              ),
              onPressed: () => NavigationService()
                  .navigateTo(ADD_EVENT, arguments: store.showEvent)),
          //DELETE ACTION IN DETAIL PAGE
          IconButton(
              icon: Icon(
                Icons.delete,
                color: white,
              ),
              onPressed: () {
                store.removeEvent(store.showEvent);
                NavigationService().pop();
              })
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              store.showEvent.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: white, fontSize: 20),
            ),
          ),
        ),
        backgroundColor: blue,
      ),
      SliverFillRemaining(
        child: _buildInfoEvent(store),
      )
    ]);
  }

  Widget _buildInfoEvent(ShowEventViewModel store) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          store.showEvent.description != null &&
                  store.showEvent.description.isNotEmpty
              ? _buildDescription(store.showEvent)
              : SizedBox(
                  height: 0,
                ),
          _buildTime(store.showEvent, start: true),
          _buildTime(store.showEvent, start: false),
        ],
      ),
    );
  }

  Widget _buildDescription(Event event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.subject,
              color: lightGrey,
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Text(
                event.description,
                textAlign: TextAlign.left,
                maxLines: 100,
                style: Theme.of(context).textTheme.subtitle1,
              ))
        ],
      ),
    );
  }

  Widget _buildTime(Event event, {bool start}) {
    var _formatterDate =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    var _formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 8),
              child: start
                  ? Icon(
                      FeatherIcons.clock,
                      color: darkBlue,
                    )
                  : Icon(
                      FeatherIcons.circle,
                      color: darkBlue,
                    )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                      _formatterTime.format(start ? event.start : event.end),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: darkBlue),
                    )),
                Text(_formatterDate.format(start ? event.start : event.end)),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
