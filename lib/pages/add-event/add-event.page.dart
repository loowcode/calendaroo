import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/common/page-title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
    _endDate = _startDate;
    _endTime = now.add(Duration(hours: 1));
  }

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
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          PageTitle('Nuovo Evento'),
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
                    .bodyText2
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
                      .bodyText2
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
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return _buildDatePicker(context, start);
              },
            ),
            child: Chip(
              backgroundColor: backgroundForm,
              label: Text(_formatterDate.format(start ? _startDate : _endDate)),
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
              label: Text(_formatterTime.format(start ? _startTime : _endTime)),
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

  Widget _buildDatePicker(BuildContext context, bool start) {
    DateTime _current = start ? _startDate : _endDate;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 250,
//              child: CupertinoTheme(
//                data: cupertinoTheme.copyWith(textTheme: textTheme),
              child: CupertinoDatePicker(
                initialDateTime: start ? _startDate : _endDate,
                minimumDate: start ? null : _startDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  _current = value;
                },
              ),
//              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      textColor: secondaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Cancel'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Save'),
                      ),
                      color: AppTheme.primaryTheme.buttonColor,
                      textColor: AppTheme.primaryTheme.textTheme.button.color,
                      onPressed: () {
                        setState(() {
                          if (start) {
                            _startDate = _current;

                            if (_endDate.isBefore(_startDate)) {
                              _endDate = _startDate;
                            }
                          } else {
                            _endDate = _current;
                          }
                        });

                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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
    return Event(
        id: null,
        title: _title,
        uuid: uuid.v4(),
        description: _description,
        start: DateTime(_startDate.year, _startDate.month, _startDate.day,
            _startTime.hour, _startTime.minute),
        end: DateTime(_endDate.year, _endDate.month, _endDate.day,
            _endTime.hour, _endTime.minute));
  }
}
