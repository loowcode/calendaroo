import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/colors.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:calendaroo/utils/string.utils.dart';
import 'package:calendaroo/widgets/card/card.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget>
    with TickerProviderStateMixin {
  AutoScrollController _listController;

  @override
  void initState() {
    super.initState();
    _listController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   calendarooState.dispatch(SelectDay(Date.today()));
    // });
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );
    return BlocBuilder<CalendarBloc, CalendarState>(
      // onDidChange: (viewModel) {
      //   try {
      //     _listController.scrollToIndex(
      //         CalendarUtils.getIndex(
      //             viewModel.eventMapped, viewModel.selectedDay),
      //         preferPosition: AutoScrollPosition.begin);
      //   } catch (e) {
      //     print('no events for selected day');
      //   }
      // },
      builder: (context, state) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(color: white, borderRadius: radius),
            child: Stack(
              children: <Widget>[
                ListView(
                    controller: _listController,
                    padding: EdgeInsets.all(16),
                    children: _buildAgenda(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAgenda(CalendarState state) {
    var mapEvent = state is CalendarLoaded ? state.mappedCalendarItems : null;
    var widgets = <Widget>[];
    if (mapEvent == null || mapEvent.isEmpty) {
      return [_buildEmptyAgenda()];
    }

    var formatter =
        DateFormat('dd MMMM, EEEE', Localizations.localeOf(context).toString());
    for (var date in mapEvent.keys) {
      var row = <Widget>[];
      var list = mapEvent[date];
      row
        ..add(
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                StringUtils.titleCase(formatter.format(date)),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        )
        ..addAll(list
            .map(
              (elem) => Container(child: CardWidget(elem)),
            )
            .toList())
        ..add(
          SizedBox(
            height: 16,
          ),
        );
      var dayGroup = AutoScrollTag(
        key: ValueKey(CalendarUtils.getIndex(mapEvent, date)),
        index: CalendarUtils.getIndex(mapEvent, date),
        controller: _listController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: row,
        ),
      );
      widgets.add(dayGroup);
    }
    widgets.add(SizedBox(
      height: 800,
    ));
    return widgets;
  }

  Container _buildEmptyAgenda() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).noEvents,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
                margin: EdgeInsets.only(top: 32),
                child: Icon(
                  Icons.event_available,
                  size: 64,
                  color: lightGrey,
                ))
          ],
        ),
      ),
    );
  }
}
