import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/pages/show-event/show-event.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ShowEventPage extends StatefulWidget {
  Event event;

  ShowEventPage(this.event);

  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  String _uuid;
  DateTime _startDate;
  DateTime _endDate;
  DateTime _startTime;
  DateTime _endTime;
  var _canModify = false;

  var _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = calendarooState.state.calendarState.showEvent.title;
    _uuid = calendarooState.state.calendarState.showEvent.uuid;
    _titleController.text = _title;
    _description = calendarooState.state.calendarState.showEvent.description;
    final now = DateTime.now();
    _startDate = now;
    _startTime = now;
    _endDate = now.add(Duration(days: 1));
    _endTime = now.add(Duration(hours: 1));
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    return Scaffold(
      body: StoreConnector<AppState, ShowEventViewModel>(
          converter: (store) => ShowEventViewModel.fromStore(store),
          builder: (context, store) {
            return _buildHead(store, event);
          }),
    );
  }

  Widget _buildHead(ShowEventViewModel store, Event event) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 200,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        floating: false,
        pinned: true,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: primaryWhite),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: primaryWhite,
              ),
              onPressed: () => NavigationService().navigateTo(ADD_EVENT))
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            event.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: primaryWhite, fontSize: 20),
          ),
        ),
        backgroundColor: secondaryBlue,
      ),
      SliverFillRemaining(
        child: _buildBody(store, event),
      )
    ]);
  }

  Widget _buildBody(ShowEventViewModel store, Event event) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          event.description != null && event.description.isNotEmpty
              ? _buildDescription(event)
              : null,
          SizedBox(
            height: 24,
          ),
          _buildTime(true),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildTime(false),
          ),
        ],
      ),
    );
  }

  Row _buildDescription(Event event) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.subject,
            color: secondaryLightGrey,
          ),
        ),
        Text(
          event.description,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }

  Widget _buildTime(bool start) {
    var _formatterDate =
        new DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    var _formatterTime =
        new DateFormat.Hm(Localizations.localeOf(context).toString());
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 8),
            child: start
                ? FaIcon(
                    FontAwesomeIcons.clock,
                    color: secondaryDarkBlue,
                  )
                : FaIcon(
                    FontAwesomeIcons.dotCircle,
                    color: secondaryDarkBlue,
                  )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(
//              start ? 'Inizio Evento' : 'Fine Evento',
//              textAlign: TextAlign.left,
//              style: Theme.of(context).textTheme.subtitle2,
//            ),
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                    _formatterTime.format(start ? _startTime : _endTime),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: secondaryDarkBlue),
                  )),
              Text(_formatterDate.format(start ? _startDate : _endDate)),
            ]),
          ],
        ),
      ],
    );
  }
}
