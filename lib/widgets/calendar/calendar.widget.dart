import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:calendaroo/widgets/calendar/calendar.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void updateController(DateTime newSelectedDay) {
    if (_calendarController != null) {
      if (newSelectedDay != null &&
          _calendarController.selectedDay != newSelectedDay) {
        setState(() {
          _calendarController.setSelectedDay(newSelectedDay);
        });
      }
    }
  }

  void _onDaySelected(CalendarViewModel store, DateTime day, List events) {
    store.selectDay(Date.convertToDate(day));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    if (format == CalendarFormat.month) {
      SharedPreferenceService().setCalendarFormat('month');
    }
    if (format == CalendarFormat.twoWeeks) {
      SharedPreferenceService().setCalendarFormat('twoWeeks');
    }
    if (format == CalendarFormat.week) {
      SharedPreferenceService().setCalendarFormat('week');
    }
  }

  void _onCalendarCreated(CalendarViewModel store, DateTime first,
      DateTime last, CalendarFormat format) {
    store.selectDay(Date.today());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CalendarViewModel>(
        converter: (store) => CalendarViewModel.fromStore(store),
        onWillChange: (oldViewModel, newViewModel) {
          updateController(newViewModel.selectedDay);
        },
        builder: (context, store) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: cyanGradient)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                _buildHeaderTable(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildTableCalendarWithBuilders(store),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildHeaderTable() {
    var yearFormatter =
        DateFormat.yMMMM(Localizations.localeOf(context).toString());
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () => _selectPrevious(),
              icon: Icon(
                Icons.chevron_left,
                color: white,
              )),
          Text(
            _calendarController == null ||
                    _calendarController.focusedDay == null
                ? ''
                : yearFormatter.format(_calendarController.focusedDay),
            style: Theme.of(context).textTheme.headline5.copyWith(color: white),
          ),
          IconButton(
              onPressed: () => _selectNext(),
              icon: Icon(
                Icons.chevron_right,
                color: white,
              ))
        ],
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(CalendarViewModel store) {
    var locale = Localizations.localeOf(context);
    return TableCalendar(
      calendarController: _calendarController,
      events: store.eventMapped,
      holidays: holidays,
      headerVisible: false,
      initialCalendarFormat: SharedPreferenceService().calendarFormat,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: {
        CalendarFormat.month: 'month',
        CalendarFormat.twoWeeks: 'twoWeeks',
        CalendarFormat.week: 'week'
      },
      locale: locale.toString(),
      calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          outsideHolidayStyle: TextStyle().copyWith(color: transparentWhite),
          outsideWeekendStyle: TextStyle().copyWith(color: transparentWhite),
          outsideStyle: TextStyle().copyWith(color: transparentWhite),
          weekendStyle: TextStyle().copyWith(color: white),
          holidayStyle: TextStyle().copyWith(color: white),
          weekdayStyle: TextStyle().copyWith(color: white)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: white),
          weekdayStyle: TextStyle().copyWith(color: white)),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: white),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0, color: blue),
                  ),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: transparentWhite),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0, color: darkBlue),
                ),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(_buildEventsMarker(date, events));
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(store, date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated:
          (DateTime first, DateTime last, CalendarFormat format) =>
              _onCalendarCreated(store, first, last, format),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 28),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: events
                    .map((e) => Padding(
                        padding: EdgeInsets.only(left: 1, right: 1),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pink,
                          ),
                        )))
                    .toList())));
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.stars,
      size: 20.0,
      color: yellow,
    );
  }

  void _onHeaderTapped(DateTime focusedDay) {}

  void _selectPrevious() {
    var calendarFormat = _calendarController.calendarFormat;
    var focusesDay = _calendarController.focusedDay;
    var newFocus = focusesDay;
    if (_calendarController.calendarFormat == CalendarFormat.month) {
      if (focusesDay.month == 1) {
        newFocus = DateTime(focusesDay.year - 1, 12);
      } else {
        newFocus = DateTime(focusesDay.year, focusesDay.month - 1);
      }
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      if (_calendarController.visibleDays.take(7).contains(focusesDay)) {
        // in top row
        newFocus = focusesDay.subtract(const Duration(days: 7));
      } else {
        // in bottom row OR not visible
        newFocus = focusesDay.subtract(Duration(days: 14));
      }
    } else {
      newFocus = focusesDay.subtract(const Duration(days: 7));
    }
    setState(() {
      _calendarController.setFocusedDay(newFocus);
    });
  }

  void _selectNext() {
    var calendarFormat = _calendarController.calendarFormat;
    var focusesDay = _calendarController.focusedDay;
    var newFocus = focusesDay;
    if (_calendarController.calendarFormat == CalendarFormat.month) {
      if (focusesDay.month == 12) {
        newFocus = DateTime(focusesDay.year + 1, 12);
      } else {
        newFocus = DateTime(focusesDay.year, focusesDay.month + 1);
      }
    } else if (calendarFormat == CalendarFormat.twoWeeks) {
      if (!_calendarController.visibleDays.skip(7).contains(focusesDay)) {
        // in top row
        newFocus = focusesDay.add(const Duration(days: 7));
      } else {
        // in bottom row OR not visible
        newFocus = focusesDay.add(Duration(days: 14));
      }
    } else {
      newFocus = focusesDay.add(const Duration(days: 7));
    }
    setState(() {
      _calendarController.setFocusedDay(newFocus);
    });
  }
}
