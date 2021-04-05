import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/upcoming_events/upcoming_events.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [CalendarWidget(), UpcomingEventsWidget()]);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalendarBloc>(context).add(CalendarLoadEvent());
  }
}
