import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/widgets/card/card.widget.dart';
import 'package:calendaroo/widgets/today-completion-circle/today-completion-circle.widget.dart';
import 'package:calendaroo/widgets/todaylist/todaylist.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    return StoreConnector<AppState, TodayListViewModel>(
        converter: (store) => TodayListViewModel.fromStore(store),
        builder: (context, store) {
          var todayList = store.eventMapped[Date.today()];
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
