import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/pages/details/details.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../theme.dart';

class DetailsPage extends StatefulWidget {
  final Event event;

  DetailsPage(this.event);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _title;
  String _description;
  DateTime _startDate;
  DateTime _endDate;
  DateTime _startTime;
  DateTime _endTime;
  bool _allDay = false;
  Event _showEvent;

  bool _edited;

  @override
  void initState() {
    super.initState();
    _showEvent = widget.event;
    _title = _showEvent?.title ?? '';
    _description = _showEvent?.description ?? '';
    final now = DateTime.now();
    var defaultTime = now;
    if (calendarooState.state.calendarState.selectedDay.isAfter(now)) {
      defaultTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    }
    _startDate =
        _showEvent?.start ?? calendarooState.state.calendarState.selectedDay;
    _startTime = _showEvent?.start ?? defaultTime;
    _endDate = _showEvent?.end ?? _startDate;
    _endTime = _showEvent?.end ?? defaultTime.add(Duration(hours: 1));

    _edited = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, DetailsViewModel>(
          converter: (store) => DetailsViewModel.fromStore(store),
          builder: (context, store) {
            return _buildPage(store);
          }),
    );
  }

  Widget _buildPage(DetailsViewModel store) {
    var _formatterDate =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    var _formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());
    return Container(
        margin: EdgeInsets.only(top: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          _buildAppBar(store),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 32),
                        child: TextFormField(
                          initialValue: _title,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context).addTitle),
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              _title = value;
                              _edited = true;
                            });
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 32),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.alarm, color: _allDay ? grey : blue),
                              Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Icon(Icons.refresh, color: grey))
                            ],
                          )),
                      _rowTile(
                        Icon(Icons.subject, color: grey),
                        TextFormField(
                          initialValue: _description,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context).addDescription),
                          style: Theme.of(context).textTheme.bodyText1,
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                              _edited = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 52,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                AppLocalizations.of(context).allDay,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _allDay,
                              activeColor: blue,
                              onChanged: (value) {
                                setState(() {
                                  _allDay = value;
                                  _edited = true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      _rowTile(
                          Icon(FeatherIcons.calendar, color: grey),
                          GestureDetector(
                              onTap: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return _buildDatePicker(true);
                                    },
                                  ),
                              child: Text(
                                _formatterDate.format(_startDate),
                                style: Theme.of(context).textTheme.subtitle1,
                              ))),
                      _rowTile(
                          SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                              onTap: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return _buildDatePicker(false);
                                    },
                                  ),
                              child: Text(
                                _formatterDate.format(_endDate),
                                style: Theme.of(context).textTheme.subtitle1,
                              ))),
                      !_allDay
                          ? SizedBox(
                              height: 52,
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Icon(FeatherIcons.clock,
                                            color: grey),
                                      ),
                                      GestureDetector(
                                          onTap: () => showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return _buildTimePicker(true);
                                                },
                                              ),
                                          child: Text(
                                            _formatterTime.format(_startTime),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 52.0),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Icon(Icons.alarm_off,
                                              color: grey),
                                        ),
                                        GestureDetector(
                                            onTap: () => showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return _buildDatePicker(
                                                        false);
                                                  },
                                                ),
                                            child: Text(
                                              _formatterTime.format(_endTime),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                          : SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }

  Row _buildAppBar(DetailsViewModel store) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FeatherIcons.arrowLeft,
              ),
              onPressed: () {
                NavigationService().pop();
              },
            ),
            _edited || !_isEdit()
                ? IconButton(
                    icon: Icon(
                      FeatherIcons.save,
                      color: blue,
                    ),
                    onPressed: () {
                      if (_isEdit()) {
                        store.editEvent(_createNewEvent(_showEvent.id));
                      } else {
                        store.createEvent(_createNewEvent(null));
                      }
                      NavigationService().pop();
                    },
                  )
                : SizedBox(),
          ],
        );
  }

  Widget _rowTile(Widget leading, Widget title) {
    return SizedBox(
      height: 52,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: leading,
          ),
          Expanded(child: title),
        ],
      ),
    );
  }

  Widget _buildDatePicker(bool start) {
    var _current = start ? _startDate : _endDate;

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
              child: CupertinoDatePicker(
                initialDateTime: start ? _startDate : _endDate,
                minimumDate: start ? null : _startDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  _current = value;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      textColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context).cancel),
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
                        child: Text(AppLocalizations.of(context).save),
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
                          _edited = true;
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

  Widget _buildTimePicker(bool start) {
    var _current = start ? _startTime : _endTime;

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
              child: CupertinoDatePicker(
                initialDateTime: start ? _startTime : _endTime,
                minimumDate: start ? null : _startTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  _current = value;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      textColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context).cancel),
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
                        child: Text(AppLocalizations.of(context).save),
                      ),
                      color: AppTheme.primaryTheme.buttonColor,
                      textColor: AppTheme.primaryTheme.textTheme.button.color,
                      onPressed: () {
                        setState(() {
                          if (start) {
                            _startTime = _current;

                            if (_endTime.isBefore(_startTime)) {
                              _endTime = _startTime;
                            }
                          } else {
                            _endTime = _current;
                          }
                          _edited = true;
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

  bool _isEdit() {
    return _showEvent != null;
  }

  Event _createNewEvent(int id) {
    var uuid = Uuid();
    return Event(
        id: id,
        title: _title,
        uuid: uuid.v4(),
        description: _description,
        start: DateTime(_startDate.year, _startDate.month, _startDate.day,
            _startTime.hour, _startTime.minute),
        end: DateTime(_endDate.year, _endDate.month, _endDate.day,
            _endTime.hour, _endTime.minute));
  }
}
