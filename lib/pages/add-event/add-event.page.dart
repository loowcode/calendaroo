import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'add-event.viewmodel.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  DateTime _startDate;
  DateTime _endDate;
  DateTime _startTime;
  DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _title = "";
    _description = "";
    final now = DateTime.now();
    _startDate = calendarooState.state.calendarState.selectedDay;
    _startTime = now;
    _endDate = now;
    _endTime = now.add(Duration(hours: 1));
  }

  // TODO grafica e translate
  @override
  Widget build(BuildContext context) {
    var _formatterDate =
        new DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    var _formatterTime =
        new DateFormat.Hm(Localizations.localeOf(context).toString());
    return StoreConnector<AppState, AddEventViewModel>(
        converter: (store) => AddEventViewModel.fromStore(store),
        builder: (context, store) {
          return Scaffold(
            body: Form(
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
                              Text('Nuovo Evento',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.display1),
                              IconButton(
                                  onPressed: () {
                                    NavigationService().pop();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: secondaryLightGrey,
                                  ))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          _buildTitle(),
                          _buildTime(store, true, context, _formatterDate,
                              _formatterTime),
                          _buildTime(store, false, context, _formatterDate,
                              _formatterTime),
                        ],
                      ),
                    ),
                    _buildButton(store, context)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Column _buildTitle() {
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
                labelText: 'Titolo',
                labelStyle: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: primaryBlack),
              ),
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
                  labelText: 'Descrizione',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: primaryBlack),
                ),
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

  Column _buildTime(AddEventViewModel store, bool start, BuildContext context,
      DateFormat _formatterDate, DateFormat _formatterTime) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Text(
          start ? 'Inizio Evento' : 'Fine Evento',
          style: Theme.of(context).textTheme.subtitle,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTap: () => CupertinoRoundedDatePicker.show(
              context,
              locale: Localizations.localeOf(context),
//              minimumYear: 1700,
              initialDate: _startDate,
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
            ),
            child: Chip(
              backgroundColor: backgroundForm,
              label: Text(_formatterDate.format(_startDate)),
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
            onTap: () => CupertinoRoundedDatePicker.show(
              context,
              locale: Localizations.localeOf(context),
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
            ),
            child: Chip(
              backgroundColor: backgroundForm,
              label: Text(_formatterTime.format(_startTime)),
              avatar: Icon(
                Icons.access_time,
                color: accentPink,
              ),
            ),
          ),
        ],
      )
    ]);
  }

  Padding _buildButton(AddEventViewModel store, BuildContext context) {
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
            print('valido');
            store.createEvent(_createNewEvent());
            NavigationService().pop();
          }
        },
        child: SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: Text(
              'Crea Evento',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Event _createNewEvent() {
    var uuid = Uuid();
    print(_startTime);
    return Event(
        id: null,
        title: _title,
        description: _description,
        start: DateTime(_startDate.year, _startDate.month, _startDate.day,
            _startTime.hour, _startTime.minute),
        end: DateTime(_endDate.year, _endDate.month, _endDate.day,
            _endTime.hour, _endTime.minute));
  }
}
