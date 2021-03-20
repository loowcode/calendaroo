import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/alarm.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/pages/details/details.viewmodel.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:calendaroo/utils/event.utils.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

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
  bool _allDay;
  Event _showEvent;
  Repeat _repeat;
  DateTime _until;
  List<Alarm> _alarms;

  bool _edited;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    var defaultTime = now;
    if (calendarooState.state.calendarState.selectedDay.isAfter(now)) {
      defaultTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    }

    _showEvent = widget.event;
    _title = _showEvent?.title ?? '';
    _description = _showEvent?.description ?? '';
    _startDate =
        _showEvent?.start ?? calendarooState.state.calendarState.selectedDay;
    _startTime = _showEvent?.start ?? defaultTime;
    _endDate = _showEvent?.end ?? _startDate;
    _endTime = setEndTime(defaultTime);

    _allDay = _showEvent?.allDay ?? false;
    _repeat = _showEvent?.repeat ?? Repeat(type: RepeatType.never);
    _alarms = [Alarm(1, _startDate.subtract(Duration(minutes: 15)), false)];

    _edited = false;
  }

  DateTime setEndTime(DateTime defaultTime) {
    var toRet = _showEvent?.end ?? defaultTime.add(Duration(hours: 1));
    if (toRet.isBefore(_startTime)) {
      toRet = CalendarUtils.removeDate(DateTime(2000, 1, 1, 23, 59));
    }
    return toRet;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DetailsViewModel>(
        converter: (store) => DetailsViewModel.fromStore(store),
        builder: (context, store) {
          return Scaffold(
              body: _buildPage(store),
              bottomNavigationBar: BottomAppBar(
                color: white,
                child: Container(
                  child: _buildBottomBar(store),
                ),
              ));
        });
  }

  Row _buildBottomBar(DetailsViewModel store) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.attach_file,
        //     color: grey,
        //   ),
        //   onPressed: () => null,
        // ),
        IconButton(
          icon: Icon(
            FeatherIcons.trash,
            color: grey,
          ),
          onPressed: () {
            store.deleteEvent();
            NavigationService().pop();
          },
        ),
        IconButton(
          icon: Icon(
            FeatherIcons.save,
            color: _edited || !_isEdit() ? blue : grey,
          ),
          onPressed: () {
            if (_isEdit()) {
              store.editEvent(_createNewEvent(_showEvent.id));
            } else {
              store.createEvent(_createNewEvent(null));
            }
            NavigationService().pop();
          },
        ),
        // IconButton(
        //   icon: Icon(
        //     FeatherIcons.moreVertical,
        //     color: grey,
        //   ),
        //   onPressed: null,
        // ),
      ],
    );
  }

  Widget _buildPage(DetailsViewModel store) {
    var _formatterDate =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    var _formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());
    return SafeArea(
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
                      maxLines: 3,
                      minLines: 1,
                      scrollPadding: EdgeInsets.all(0),
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
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                          _edited = true;
                        });
                      },
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(left: 32),
                  //     child: _buildBadges()),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Padding(
                        padding: EdgeInsets.only(top: 0, right: 16),
                        child: Icon(Icons.subject, color: grey)),
                    Expanded(
                      child: TextFormField(
                        maxLines: 4,
                        minLines: 1,
                        scrollPadding: EdgeInsets.all(0),
                        initialValue: _description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(0),
                            focusedErrorBorder: InputBorder.none,
                            hintText:
                                AppLocalizations.of(context).addDescription),
                        style: Theme.of(context).textTheme.bodyText1,
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                            _edited = true;
                          });
                        },
                      ),
                    ),
                  ]),
                  _rowTile(
                      leading: Icon(FeatherIcons.calendar, color: grey),
                      title: GestureDetector(
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
                      leading: SizedBox(
                        width: 24,
                      ),
                      title: GestureDetector(
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
                  _rowTile(
                      title: Text(
                        AppLocalizations.of(context).allDay,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: CupertinoSwitch(
                        value: _allDay,
                        activeColor: blue,
                        onChanged: (bool value) {
                          setState(() {
                            _allDay = value;
                            _edited = true;
                          });
                        },
                      )),
                  !_allDay
                      ? SizedBox(
                          height: 42,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child:
                                        Icon(Icons.alarm, color: grey),
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
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Icon(Icons.alarm_off, color: grey),
                                    ),
                                    GestureDetector(
                                        onTap: () => showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return _buildTimePicker(false);
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
                  // _rowTile(
                  //     leading: Icon(FeatherIcons.repeat, color: grey),
                  //     title: GestureDetector(
                  //         onTap: () => showModalBottomSheet(
                  //               context: context,
                  //               builder: _buildRepeatModal,
                  //             ),
                  //         child: Text(
                  //           AppLocalizations.of(context).translate(
                  //               Repeat.repeatToString(_repeat.type)),
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ))),
                  // _repeat.type != RepeatType.never
                  //     ? _rowTile(
                  //         leading: Icon(Icons.vertical_align_bottom,
                  //             color: grey),
                  //         title: GestureDetector(
                  //             onTap: () async {
                  //               FocusScope.of(context)
                  //                   .requestFocus(FocusNode());
                  //               var stop = await showDatePicker(
                  //                   context: context,
                  //                   initialDate: DateTime.now(),
                  //                   firstDate: _startDate,
                  //                   lastDate: DateTime(3000));
                  //               if (stop != null) {
                  //                 setState(() {
                  //                   _until = stop;
                  //                   _edited = true;
                  //                 });
                  //               }
                  //             },
                  //             child: Text(
                  //               _until != null
                  //                   ? '${AppLocalizations.of(context).until} ${_formatterDate.format(_until)}'
                  //                   : AppLocalizations.of(context)
                  //                       .setStopDate,
                  //               style:
                  //                   Theme.of(context).textTheme.bodyText1,
                  //               maxLines: 2,
                  //             )),
                  //         trailing: _until != null
                  //             ? IconButton(
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     _until = null;
                  //                   });
                  //                 },
                  //                 icon: Icon(Icons.close, color: grey),
                  //               )
                  //             : SizedBox())
                  //     : SizedBox(),
                  // _rowTile(
                  //     leading: Icon(
                  //       FeatherIcons.bell,
                  //       color: grey,
                  //     ),
                  //     title: GestureDetector(
                  //         onTap: () async {},
                  //         child: Text(
                  //           _alarms.isEmpty ? 'set alarm' : 'alarm',
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         )))
                ],
              ),
            )
          ],
        ),
      )
    ]));
  }

  Widget _buildBadges() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Icon(Icons.alarm, color: _allDay ? grey : blue),
          Container(
              margin: EdgeInsets.only(left: 8),
              child: Icon(FeatherIcons.repeat,
                  color: _repeat.type == RepeatType.never ? grey : blue))
        ],
      ),
    );
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
      ],
    );
  }

  Widget _rowTile({Widget leading, Widget title, Widget trailing}) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: leading ??
                SizedBox(
                  width: 24,
                  height: 24,
                ),
          ),
          Expanded(
            child: title ?? SizedBox(),
          ),
          trailing ?? SizedBox()
        ],
      ),
    );
  }

  Widget _buildDatePicker(bool start) {
    var _current = start ? _startDate : _endDate;
    FocusScope.of(context).requestFocus(FocusNode());

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
                onDateTimeChanged: (DateTime value) {
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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: blue,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: AppTheme.primaryTheme.buttonColor,
                        elevation: 4,
                      ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context).save,
                          style: TextStyle(color: white),
                        ),
                      ),
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
    FocusScope.of(context).requestFocus(FocusNode());

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
                onDateTimeChanged: (DateTime value) {
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
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
                      color: AppTheme.primaryTheme.buttonColor,
                      textColor: AppTheme.primaryTheme.textTheme.button.color,
                      onPressed: () {
                        setState(() {
                          if (start) {
                            _startTime = _current;
                            if (_endTime.isBefore(_startTime)) {
                              var result = _startTime.add(Duration(hours: 1));
                              if (result.isBefore(_startTime)) {
                                result = CalendarUtils.removeDate(
                                    DateTime(2000, 1, 1, 23, 59));
                              }
                              _endTime = result;
                            }
                          } else {
                            _endTime = _current;
                          }
                          _edited = true;
                        });

                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context).save),
                      ),
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
    return EventUtils.createNewEvent(
      id: id,
      title: _title,
      description: _description,
      start: DateTime(_startDate.year, _startDate.month, _startDate.day,
          _startTime.hour, _startTime.minute),
      end: DateTime(_endDate.year, _endDate.month, _endDate.day, _endTime.hour,
          _endTime.minute),
      allDay: _allDay,
      repeat: _repeat,
      until: _until,
    );
  }

  Widget _buildRepeatModal(BuildContext context) {
    var selected = _repeat.type;
    FocusScope.of(context).requestFocus(FocusNode());

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setRadioState) {
      return Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  RepeatType.daily,
                  RepeatType.weekly,
                  RepeatType.monthly,
                  RepeatType.yearly,
                  RepeatType.never
                ]
                    .map((elem) => Row(children: <Widget>[
                          Radio(
                            value: elem,
                            groupValue: selected,
                            onChanged: (RepeatType value) {
                              setRadioState(() => selected = value);
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate(Repeat.repeatToString(elem)),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ]) as Widget)
                    .toList()
                      ..addAll(<Widget>[
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      textColor: blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(AppLocalizations.of(context)
                                            .cancel),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      color: AppTheme.primaryTheme.buttonColor,
                                      textColor: AppTheme
                                          .primaryTheme.textTheme.button.color,
                                      onPressed: () {
                                        setState(() {
                                          _repeat.type = selected;
                                          _edited = true;
                                        });

                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                            AppLocalizations.of(context).save),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        )
                      ]),
              )));
    });
  }
}
