import 'package:calendaroo/colors.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:calendaroo/widgets/calendar/calendar.viewmodel.dart';
import 'package:calendaroo/widgets/upcoming-events.widget.dart';
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
//  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
//
//    _events = {
//      _selectedDay.subtract(Duration(days: 30)): [
//        'Event A0',
//        'Event B0',
//        'Event C0'
//      ],
//      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//      _selectedDay.subtract(Duration(days: 20)): [
//        'Event A2',
//        'Event B2',
//        'Event C2',
//        'Event D2'
//      ],
//      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//      _selectedDay.subtract(Duration(days: 10)): [
//        'Event A4',
//        'Event B4',
//        'Event C4'
//      ],
//      _selectedDay.subtract(Duration(days: 4)): [
//        'Event A5',
//        'Event B5',
//        'Event C5'
//      ],
//      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//      _selectedDay.add(Duration(days: 1)): [
//        'Event A8',
//        'Event B8',
//        'Event C8',
//        'Event D8'
//      ],
//      _selectedDay.add(Duration(days: 3)):
//          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//      _selectedDay.add(Duration(days: 7)): [
//        'Event A10',
//        'Event B10',
//        'Event C10'
//      ],
//      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//      _selectedDay.add(Duration(days: 17)): [
//        'Event A12',
//        'Event B12',
//        'Event C12',
//        'Event D12'
//      ],
//      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//      _selectedDay.add(Duration(days: 26)): [
//        'Event A14',
//        'Event B14',
//        'Event C14'
//      ],
//    };
//
//    _selectedEvents = _events[_selectedDay] ?? [];
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

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CalendarViewModel>(
        converter: (store) => CalendarViewModel.fromStore(store),
        builder: (context, store) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 32.0),
                _buildTableCalendarWithBuilders(store),
                const SizedBox(height: 8.0),
                UpcomingEventsWidget()
//            Expanded(child: _buildEventList()),
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
      events: CalendarService().toMap(store.events),
      holidays: holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.scale,
//      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      locale: locale.toString(),
      calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          outsideHolidayStyle: TextStyle().copyWith(color: secondaryLightGrey),
          outsideWeekendStyle: TextStyle().copyWith(color: secondaryLightGrey),
          outsideStyle: TextStyle().copyWith(color: secondaryLightGrey),
          weekendStyle: TextStyle().copyWith(color: accentYellow),
          holidayStyle: TextStyle().copyWith(color: accentYellow),
          weekdayStyle: TextStyle().copyWith(color: primaryWhite)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: accentYellow),
          weekdayStyle: TextStyle().copyWith(color: primaryWhite)),
      headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.chevron_left, color: primaryWhite),
          rightChevronIcon: Icon(Icons.chevron_right, color: primaryWhite),
          centerHeaderTitle: true,
          formatButtonVisible: true,
          formatButtonTextStyle: TextStyle().copyWith(color: secondaryDarkGrey),
          titleTextStyle: TextStyle().copyWith(
              color: primaryWhite, fontSize: 28, fontWeight: FontWeight.bold)),
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
                  borderRadius: BorderRadius.circular(8), color: secondaryLightGrey),
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
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
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
}
