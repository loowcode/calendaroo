import 'package:calendaroo/colors.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:calendaroo/widgets/calendar/calendar.viewmodel.dart';
import 'package:calendaroo/widgets/upcoming-events/upcoming-events.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
        _calendarController.setSelectedDay(newSelectedDay);
      }
    }
  }

  void _onDaySelected(CalendarViewModel store, DateTime day, List events) {
    store.selectDay(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    if (format == CalendarFormat.month) {
      SharedPreferenceService().setCalendarFormat('month');
    } else {
      SharedPreferenceService().setCalendarFormat('week');
    }
  }

  void _onCalendarCreated(CalendarViewModel store, DateTime first,
      DateTime last, CalendarFormat format) {
    store.selectDay(DateTime.now());
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 32.0),
                _buildTableCalendarWithBuilders(store),
                const SizedBox(height: 2.0),
                UpcomingEventsWidget()
              ],
            ),
          );
        });
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(CalendarViewModel store) {
    var locale = Localizations.localeOf(context);
    return TableCalendar(
      calendarController: _calendarController,
      events: store.eventMapped,
      holidays: holidays,
      onHeaderTapped: _onHeaderTapped,
      initialCalendarFormat: SharedPreferenceService().calendarFormat,
      formatAnimation: FormatAnimation.scale,
//      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Compatto',
        CalendarFormat.twoWeeks: 'Espanso',
      },
      locale: locale.toString(),
      calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          outsideHolidayStyle:
              TextStyle().copyWith(color: primaryTransparentWhite),
          outsideWeekendStyle:
              TextStyle().copyWith(color: primaryTransparentWhite),
          outsideStyle: TextStyle().copyWith(color: primaryTransparentWhite),
          weekendStyle: TextStyle().copyWith(color: primaryWhite),
          holidayStyle: TextStyle().copyWith(color: primaryWhite),
          weekdayStyle: TextStyle().copyWith(color: primaryWhite)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: primaryWhite),
          weekdayStyle: TextStyle().copyWith(color: primaryWhite)),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left, color: primaryWhite),
        rightChevronIcon: Icon(Icons.chevron_right, color: primaryWhite),
        centerHeaderTitle: true,
        formatButtonVisible: true,
        formatButtonDecoration:
            BoxDecoration(border: Border.all(color: transparent)),
        formatButtonTextStyle:
            TextStyle().copyWith(color: primaryTransparentWhite),
        titleTextStyle:
            Theme.of(context).textTheme.headline5.copyWith(color: primaryWhite),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryWhite),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle()
                        .copyWith(fontSize: 16.0, color: secondaryBlue),
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
                  color: primaryTransparentWhite),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle()
                      .copyWith(fontSize: 16.0, color: secondaryDarkBlue),
                ),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 0,
                child: _buildEventsMarker(date, events),
              ),
            );
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(3),
        color: _calendarController.isSelected(date)
            ? accentPink
            : _calendarController.isToday(date) ? accentPink : accentPink,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: primaryWhite,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  void _onHeaderTapped(DateTime focusedDay) {}
}
