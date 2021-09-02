import 'package:calendaroo/blocs/details/details_bloc.dart';
import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../theme.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage();

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    // TODO: migrate to bloc
    // if (calendarooState.state.calendarState.selectedDay.isAfter(now)) {
    //   defaultTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<DetailsBloc>(context);

    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildPage(bloc, state),
          bottomNavigationBar: BottomAppBar(
            color: white,
            child: Container(
              child: _buildBottomBar(bloc, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(DetailsBloc bloc, DetailsState state) {
    var _formatterDate =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    var _formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAppBar(),
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
                          initialValue: state.title,
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
                            bloc.add(DetailsValuesChangedEvent(title: value));
                          },
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0, right: 16),
                            child: Icon(Icons.subject, color: grey),
                          ),
                          Expanded(
                            child: TextFormField(
                              maxLines: 4,
                              minLines: 1,
                              scrollPadding: EdgeInsets.all(0),
                              initialValue: state.description,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  focusedErrorBorder: InputBorder.none,
                                  hintText: AppLocalizations.of(context)
                                      .addDescription),
                              style: Theme.of(context).textTheme.bodyText1,
                              onChanged: (value) {
                                bloc.add(DetailsValuesChangedEvent(
                                  description: value,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                      _rowTile(
                        leading: Icon(FeatherIcons.calendar, color: grey),
                        title: GestureDetector(
                          onTap: () => showModalBottomSheet<Widget>(
                            context: context,
                            builder: (context) {
                              return _buildDatePicker(bloc, state, true);
                            },
                          ),
                          child: Text(
                            _formatterDate.format(state.startDate),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      _rowTile(
                        leading: const SizedBox(
                          width: 24,
                        ),
                        title: GestureDetector(
                          onTap: () => showModalBottomSheet<Widget>(
                            context: context,
                            builder: (context) {
                              return _buildDatePicker(bloc, state, false);
                            },
                          ),
                          child: Text(
                            _formatterDate.format(state.endDate),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      _rowTile(
                        title: Text(
                          AppLocalizations.of(context).allDay,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        trailing: CupertinoSwitch(
                          value: state.allDay,
                          activeColor: blue,
                          onChanged: (bool value) {
                            bloc.add(DetailsValuesChangedEvent(allDay: value));
                          },
                        ),
                      ),
                      if (!state.allDay)
                        SizedBox(
                          height: 42,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Icon(Icons.alarm, color: grey),
                                  ),
                                  GestureDetector(
                                    onTap: () => showModalBottomSheet<Widget>(
                                      context: context,
                                      builder: (context) {
                                        return _buildTimePicker(
                                            bloc, state, true);
                                      },
                                    ),
                                    child: Text(
                                      _formatterTime.format(state.startTime),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 52.0),
                                child: Row(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Icon(Icons.alarm_off, color: grey),
                                    ),
                                    GestureDetector(
                                      onTap: () => showModalBottomSheet<Widget>(
                                        context: context,
                                        builder: (context) {
                                          return _buildTimePicker(
                                              bloc, state, false);
                                        },
                                      ),
                                      child: Text(
                                        _formatterTime.format(state.endTime),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        const SizedBox(),
                      _rowTile(
                        leading: Icon(FeatherIcons.repeat, color: grey),
                        title: GestureDetector(
                          onTap: () => showModalBottomSheet<Widget>(
                            context: context,
                            builder: (context) {
                              return _buildRepeatModal(context, bloc, state);
                            },
                          ),
                          child: Text(
                            _getRepeatText(state.repeat),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      state.repeat != Repeat.never
                          ? _rowTile(
                              leading: Icon(Icons.vertical_align_bottom,
                                  color: grey),
                              title: GestureDetector(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var stop = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: state.startDate,
                                        lastDate: DateTime(3000));
                                    if (stop != null) {
                                      bloc.add(DetailsValuesChangedEvent(
                                        until: stop,
                                      ));
                                    }
                                  },
                                  child: Text(
                                    state.until != null
                                        ? '${AppLocalizations.of(context).until} ${_formatterDate.format(state.until)}'
                                        : AppLocalizations.of(context)
                                            .setStopDate,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    maxLines: 2,
                                  )),
                              trailing: state.until != null
                                  ? IconButton(
                                      onPressed: () {
                                        bloc.add(DetailsValuesChangedEvent(
                                          until:
                                              null, // TODO: probabilmente col null non lancia l'evento
                                        ));
                                      },
                                      icon: Icon(Icons.close, color: grey),
                                    )
                                  : SizedBox())
                          : SizedBox(),
                      _rowTile(
                        leading: Icon(
                          FeatherIcons.bell,
                          color: grey,
                        ),
                        title: GestureDetector(
                          onTap: () async {},
                          child: Text(
                            state.alarms.isEmpty ? 'set alarm' : 'alarm',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          FeatherIcons.arrowLeft,
        ),
        onPressed: () {
          NavigationService().pop();
        },
      ),
      elevation: 0,
    );
  }

  Row _buildBottomBar(DetailsBloc bloc, DetailsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            FeatherIcons.trash,
            color: grey,
          ),
          onPressed: () {
            bloc.add(DetailsDeleteEvent()); // TODO: delete event
            NavigationService().pop();
          },
        ),
        IconButton(
          icon: Icon(
            FeatherIcons.save,
            color: state.edited || !_isEdit(state) ? blue : grey,
          ),
          onPressed: () {
            bloc.add(DetailsSaveEvent());
            NavigationService().pop();
          },
        ),
      ],
    );
  }

  Widget _buildBadges(DetailsState state) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Icon(Icons.alarm, color: state.allDay ? grey : blue),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Icon(FeatherIcons.repeat,
                color: state.repeat == Repeat.never ? grey : blue),
          )
        ],
      ),
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

  Widget _buildDatePicker(DetailsBloc bloc, DetailsState state, bool start) {
    var _current = start ? state.startDate : state.endDate;
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
                initialDateTime: start ? state.startDate : state.endDate,
                minimumDate: start ? null : state.startDate,
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
                        DateTime newStartDate;
                        DateTime newEndDate;

                        if (start) {
                          newStartDate = _current;

                          if (state.endDate.isBefore(state.startDate)) {
                            newEndDate = state.startDate;
                          }
                        } else {
                          newEndDate = _current;
                        }

                        bloc.add(DetailsValuesChangedEvent(
                          startDate: newStartDate ?? state.startDate,
                          endDate: newEndDate ?? state.endDate,
                        ));
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

  Widget _buildTimePicker(DetailsBloc bloc, DetailsState state, bool start) {
    var _current = start ? state.startTime : state.endTime;
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
                initialDateTime: start ? state.startTime : state.endTime,
                minimumDate: start ? null : state.startTime,
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
                        DateTime newStartTime;
                        DateTime newEndTime;

                        if (start) {
                          newStartTime = _current;
                          if (state.endTime.isBefore(state.startTime)) {
                            var result =
                                state.startTime.add(Duration(hours: 1));
                            if (result.isBefore(state.startTime)) {
                              result = CalendarUtils.removeDate(
                                  DateTime(2000, 1, 1, 23, 59));
                            }

                            newEndTime = result;
                          }
                        } else {
                          newEndTime = _current;
                        }

                        bloc.add(DetailsValuesChangedEvent(
                          startTime: newStartTime,
                          endTime: newEndTime,
                        ));

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

  bool _isEdit(DetailsState state) {
    return state.calendarItemId != null;
  }

  Widget _buildRepeatModal(
      BuildContext context, DetailsBloc bloc, DetailsState state) {
    var selected = state.repeat;
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
              Repeat.daily,
              Repeat.weekly,
              Repeat.monthly,
              Repeat.yearly,
              Repeat.never
            ]
                // TODO da rivedere
                .map((elem) => Row(
                      children: <Widget>[
                        Radio(
                          value: elem,
                          groupValue: selected,
                          onChanged: (Repeat value) {
                            setRadioState(() => selected = value);
                          },
                        ),
                        Text(
                          _getRepeatText(elem),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ) as Widget)
                .toList()
                  ..addAll(
                    <Widget>[
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                        AppLocalizations.of(context).cancel),
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
                                  textColor: AppTheme
                                      .primaryTheme.textTheme.button.color,
                                  onPressed: () {
                                    bloc.add(DetailsValuesChangedEvent(
                                        repeat: selected));

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:
                                        Text(AppLocalizations.of(context).save),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      );
    });
  }

  String _getRepeatText(Repeat repeat) {
    String repeatTextKey;

    switch (repeat) {
      case Repeat.daily:
        repeatTextKey = 'repeat_daily';
        break;
      case Repeat.weekly:
        repeatTextKey = 'repeat_weekly';
        break;
      case Repeat.monthly:
        repeatTextKey = 'repeat_monthly';
        break;
      case Repeat.yearly:
        repeatTextKey = 'repeat_yearly';
        break;
      case Repeat.never:
        repeatTextKey = 'repeat_never';
        break;
    }

    return AppLocalizations.of(context).translate(repeatTextKey);
  }
}
