import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/pages/show-event/show-event.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
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
    var _formatterDate =
        new DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    var _formatterTime =
        new DateFormat.Hm(Localizations.localeOf(context).toString());
    return Scaffold(
      body: StoreConnector<AppState, ShowEventViewModel>(
          converter: (store) => ShowEventViewModel.fromStore(store),
          builder: (context, store) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Evento',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _canModify = !_canModify;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.mode_edit,
                                        color: secondaryLightGrey,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        NavigationService().pop();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: secondaryLightGrey,
                                      )),
                                ],
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          buildTitle(event),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Text(
                              'Inizio Evento',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          buildTime(true, context, _formatterDate,
                              _formatterTime, event),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Text(
                              'Fine Evento',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          buildTime(false, context, _formatterDate,
                              _formatterTime, event),
                        ],
                      ),
                    ),
                    _canModify ? _buildButton(store, context) : SizedBox()
                  ],
                ),
              ),
            );
          }),
    );
  }

  Row buildTime(bool start, BuildContext context, DateFormat _formatterDate,
      DateFormat _formatterTime, Event event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (_canModify) {
              return CupertinoRoundedDatePicker.show(
                context,
//                        minimumYear: 1700,
                initialDate: start ? _startDate : _endDate,
                minimumYear: start ? 1700 : _startDate.year,
                maximumYear: 3000,
                minimumDate: start
                    ? DateTime.now().subtract(Duration(days: 7))
                    : _startDate,
                textColor: primaryWhite,
                background: secondaryBlue,
                borderRadius: 16,
                initialDatePickerMode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (newDate) {
                  setState(() {
                    if (start) {
                      _startDate = newDate;
                    } else {
                      _endDate = newDate;
                    }
                  });
                },
              );
            }
          },
          child: Chip(
            backgroundColor: backgroundForm,
            label: Text(start
                ? _formatterDate.format(event.start)
                : _formatterDate.format(event.end)),
            avatar: Icon(
              Icons.date_range,
              color: secondaryBlue,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            if (_canModify) {
              return CupertinoRoundedDatePicker.show(
                context,
                initialDate: start ? _startTime : _endTime,
                minimumYear: 1700,
                maximumYear: 3000,
                minimumDate: start
                    ? DateTime.now().subtract(Duration(days: 7))
                    : DateTime.now().subtract(Duration(days: 7)),
                textColor: primaryWhite,
                background: secondaryBlue,
                borderRadius: 16,
                initialDatePickerMode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (newDate) {
                  setState(() {
                    if (start) {
                      _startTime = newDate;
                    } else {
                      _endTime = newDate;
                    }
                  });
                },
              );
            }
          },
          child: Chip(
            backgroundColor: backgroundForm,
            label: Text(start
                ? _formatterTime.format(event.start)
                : _formatterTime.format(event.end)),
            avatar: Icon(
              Icons.access_time,
              color: accentPink,
            ),
          ),
        ),
      ],
    );
  }

  Column buildTitle(Event event) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: backgroundForm,
              borderRadius: BorderRadius.only(topRight: Radius.circular(16))),
          child: ListTile(
            leading: Icon(
              Icons.title,
              color: secondaryDarkBlue,
            ),
            title: TextFormField(
              enabled: _canModify,
              initialValue: event.title,
              decoration: new InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryDarkBlue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryDarkBlue),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryDarkBlue),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryDarkBlue),
                  ),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'Titolo'),
              validator: (value) {
                if (value != null && value.length > 0) {
                  return null;
                }
                return 'Inserisci un titolo';
              },
              onSaved: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          margin: EdgeInsets.only(top: 8, bottom: 16),
          decoration: BoxDecoration(
              color: backgroundForm,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.subject,
                color: accentYellowText,
              ),
              title: TextFormField(
                initialValue: event.description,
                enabled: _canModify,
                decoration: new InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryDarkBlue),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryDarkBlue),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryDarkBlue),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryDarkBlue),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Descrizione'),
                onSaved: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildButton(ShowEventViewModel store, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 32, right: 32),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: secondaryBlue,
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            store.editEvent(store.showEvent, _createEvent());
            NavigationService().pop();
          }
        },
        child: SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: Text(
              'Salva Modifiche',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Event _createEvent() {
    return Event(
        id: null,
        title: _title,
        uuid: _uuid,
        description: _description,
        start: DateTime(_startDate.year, _startDate.month, _startDate.day,
            _startTime.hour, _startTime.minute),
        end: DateTime(_endDate.year, _endDate.month, _endDate.day,
            _endTime.hour, _endTime.minute));
  }
}
