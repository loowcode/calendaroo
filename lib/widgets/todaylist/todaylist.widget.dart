import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/blocs/today/today_bloc.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/widgets/card/card.widget.dart';
import 'package:calendaroo/widgets/today-completion-circle/today-completion-circle.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class TodayListWidget extends StatefulWidget {
  @override
  _TodayListWidgetState createState() => _TodayListWidgetState();
}

class _TodayListWidgetState extends State<TodayListWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBloc, CalendarState>(builder: (context, store) {
      var bloc = BlocProvider.of<TodayBloc>(context);

      List<EventInstance> todayList = [];
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: <Widget>[
          TodayCompletionCircle(events: todayList),
          Row(
            children: <Widget>[
              Text(
                AppLocalizations.of(context).events,
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('${todayList.length}')),
            ],
          ),
          ...todayList.map((event) => CardWidget(event)),
        ]),
      );
    });
  }
}
