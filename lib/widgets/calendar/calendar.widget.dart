import 'package:calendaroo/colors.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:calendaroo/widgets/calendar/calendar.viewmodel.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: cyanGradient)),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildTableCalendarWithBuilders(store),
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
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: {
        CalendarFormat.month: AppLocalizations.of(context).compact,
        CalendarFormat.twoWeeks: AppLocalizations.of(context).expanded
      },
      locale: locale.toString(),
      calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          outsideHolidayStyle:
              TextStyle().copyWith(color: transparentWhite),
          outsideWeekendStyle:
              TextStyle().copyWith(color: transparentWhite),
          outsideStyle: TextStyle().copyWith(color: transparentWhite),
          weekendStyle: TextStyle().copyWith(color: white),
          holidayStyle: TextStyle().copyWith(color: white),
          weekdayStyle: TextStyle().copyWith(color: white)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: white),
          weekdayStyle: TextStyle().copyWith(color: white)),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(FeatherIcons.chevronLeft, color: white),
        rightChevronIcon: Icon(FeatherIcons.chevronRight, color: white),
        centerHeaderTitle: true,
        formatButtonVisible: true,
        formatButtonDecoration:
            BoxDecoration(border: Border.all(color: transparent)),
        formatButtonTextStyle:
            TextStyle().copyWith(color: transparentWhite),
        titleTextStyle:
            Theme.of(context).textTheme.headline5.copyWith(color: white),
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
                    color: white),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle()
                        .copyWith(fontSize: 16.0, color: blue),
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
                  style: TextStyle()
                      .copyWith(fontSize: 16.0, color: darkBlue),
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
            ? pink
            : _calendarController.isToday(date) ? pink : pink,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: white,
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
