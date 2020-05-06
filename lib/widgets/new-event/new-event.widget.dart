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
  DateTime _finishDate;
  DateTime _startTime;
  DateTime _finishTime;


  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _startTime = DateTime.now();
    _finishDate = DateTime.now().add(Duration(days: 1));
    _finishTime = DateTime.now().add(Duration(hours: 1));
  }

  // TODO grafica e translate
  @override
  Widget build(BuildContext context) {
    var _formatterDate = new DateFormat.yMMMMd(AppLocalizations.of(context).locale.toString()); // TODO locale
    var _formatterTime = new DateFormat.Hm(AppLocalizations.of(context).locale.toString()); // TODO locale
    return StoreConnector<AppState, NewEventViewModel>(
        converter: (store) => NewEventViewModel.fromStore(store),
        builder: (context, store) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8,),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Text('Crea Nuovo Evento',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline),
                        buildTitle(),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, ),
                          child: Text('Inizio Evento', style: Theme.of(context).textTheme.subtitle,),
                        ),
                        buildTime(context, _formatterDate, _formatterTime),        Padding(
                          padding: const EdgeInsets.only(top:8.0,),
                          child: Text('Fine Evento', style: Theme.of(context).textTheme.subtitle,),
                        ),
                        buildTime(context, _formatterDate, _formatterTime),

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
                        store.createEvent(_buildEvent());
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

  Row buildTime(BuildContext context, DateFormat _formatterDate, DateFormat _formatterTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text('Data', textAlign: TextAlign.left, style: Theme.of(context).textTheme.subtitle),
            Chip(
              backgroundColor: backgroundForm,
              label: InkWell(
                  onTap: () => CupertinoRoundedDatePicker.show(
                        context,
                        minimumYear: 1700,
                        maximumYear: 3000,
                        textColor: primaryWhite,
                        background: secondaryBlue,
                        borderRadius: 16,
                        initialDatePickerMode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (newDate) {
                          setState(() {
                            _startDate = newDate;
                          });
                        },
                      ),
                  child: Text(_formatterDate.format(_startDate))),
              avatar: Icon(
                Icons.date_range,
                color: secondaryBlue,
              ),
            ),
          ],
        ),
        SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text('Time', textAlign: TextAlign.left, style: Theme.of(context).textTheme.subtitle),
            Chip(
              backgroundColor: backgroundForm,
              label: InkWell(
                  onTap: () => CupertinoRoundedDatePicker.show(
                        context,
                        minimumYear: 1700,
                        maximumYear: 3000,
                        textColor: primaryWhite,
                        background: secondaryBlue,
                        borderRadius: 16,
                        initialDatePickerMode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (newDate) {
                          setState(() {
                            _startTime = newDate;
                          });
                        },
                      ),
                  child: Text(_formatterTime.format(_startTime))),
              avatar: Icon(
                Icons.access_time,
                color: accentPink,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildTitle() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:16, bottom: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: backgroundForm,
              borderRadius: BorderRadius.only(topRight: Radius.circular(16))),
          child: ListTile(
            leading: Icon(Icons.title, color: secondaryDarkBlue,),
            title: TextFormField(
              style: TextStyle(fontSize: 24),
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
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top:16, bottom: 16),
          margin: EdgeInsets.only(top:8, bottom: 16),
          decoration: BoxDecoration(
              color: backgroundForm,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          child: Container(
            child: ListTile(
              leading: Icon(Icons.subject, color: accentYellowText,),
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Event _buildEvent() {
    var uuid = Uuid();
    return Event(
        id: null,
        title: _title,
        description: _description,
        start: _startDate, // TODO aggiungere orario
        finish: _finishDate);
  }
}
