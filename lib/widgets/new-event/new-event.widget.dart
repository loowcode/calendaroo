import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/widgets/new-event/new-event.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class NewEventWidget extends StatefulWidget {
  @override
  _NewEventWidgetState createState() => _NewEventWidgetState();
}

class _NewEventWidgetState extends State<NewEventWidget> {
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
    _startDate = now;
    _startTime = now;
    _endDate = now.add(Duration(days: 1));
    _endTime = now.add(Duration(hours: 1));
  }

  // TODO grafica e translate
  @override
  Widget build(BuildContext context) {
    var _formatterDate = new DateFormat.yMMMMd(
        AppLocalizations.of(context).locale.toString()); // TODO locale
    var _formatterTime = new DateFormat.Hm(
        AppLocalizations.of(context).locale.toString()); // TODO locale
    return StoreConnector<AppState, NewEventViewModel>(
        converter: (store) => NewEventViewModel.fromStore(store),
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
                        Text('Crea Nuovo Evento',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.display1),
                        buildTitle(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Text(
                            'Inizio Evento',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        buildTime(
                            true, context, _formatterDate, _formatterTime),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Text(
                            'Fine Evento',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        buildTime(
                            false, context, _formatterDate, _formatterTime),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 32, right: 32),
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
                          store.createEvent(_buildEvent());
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
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
                  )
                ],
              ),
            ),
          );
        });
  }

  Row buildTime(bool start, BuildContext context, DateFormat _formatterDate,
      DateFormat _formatterTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        GestureDetector(
          onTap: () => CupertinoRoundedDatePicker.show(
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
    );
  }

  Column buildTitle() {
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

  Event _buildEvent() {
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
