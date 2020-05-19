import 'package:calendaroo/colors.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:calendaroo/widgets/upcoming-events/upcoming-events.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../options.widget.dart';

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget>
    with TickerProviderStateMixin {
  AutoScrollController _listController;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _listController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calendarooState.dispatch(SelectDay(DateTime.now()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );
    return StoreConnector<AppState, UpcomingEventsViewModel>(
        converter: (store) => UpcomingEventsViewModel.fromStore(store),
        onDidChange: (viewModel) {
          try {
            _listController.scrollToIndex(CalendarService()
                .getIndex(viewModel.eventMapped, viewModel.selectedDay));
//            _animationController.forward(from: 0);
          } catch (e) {
            print('no events for selected day');
          }
        },
        builder: (context, store) {
          return Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: primaryWhite, borderRadius: radius),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ListView(
                        controller: _listController,
                        padding: EdgeInsets.all(16),
                        children: _buildAgenda(store)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> _buildAgenda(UpcomingEventsViewModel store) {
    var mapEvent = store.eventMapped;
    List<Widget> widgets = [];
    if (mapEvent == null || mapEvent.isEmpty) {
      return [_buildEmptyAgenda()];
    }

    var formatterTime =
        DateFormat.Hm(Localizations.localeOf(context).toString());
    var formatter =
        DateFormat.MMMMEEEEd(Localizations.localeOf(context).toString());
    for (var date in mapEvent.keys) {
      List<Widget> row = [];
      var list = mapEvent[date];
      row
        ..add(Container(
            child: Text(
          formatter.format(date),
          style: Theme.of(context).textTheme.headline5,
        )))
        ..addAll(list
            .map((elem) => Container(
                  child: GestureDetector(
                    onTap: () {
                      store.openEvent(elem);
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(formatterTime.format(elem.start),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                  Text(formatterTime.format(elem.end),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ],
                              ),
                              title: Text(
                                elem.title,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: PopupMenuButton<Option>(
                                onSelected: selectOption,
                                color: primaryWhite,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: primaryWhite,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return options.map((Option option) {
                                    return PopupMenuItem<Option>(
                                      value: option.setEvent(elem),
                                      child: Theme(
                                          data: Theme.of(context).copyWith(
                                              cardColor: primaryWhite),
                                          child: Text(
                                            option.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(color: primaryBlack),
                                          )),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList())
        ..add(SizedBox(
          height: 16,
        ));
      AutoScrollTag dayGroup = AutoScrollTag(
        key: ValueKey(CalendarService().getIndex(mapEvent, date)),
        index: CalendarService().getIndex(mapEvent, date),
        controller: _listController,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Container(
            color: background
                .evaluate(AlwaysStoppedAnimation(_animationController.value)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: row,
            ),
          ),
        ),
      );
      widgets.add(dayGroup);
    }
    return widgets;
  }

  Container _buildEmptyAgenda() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Column(
        children: <Widget>[
          Text('Non ci sono eventi in programma',
              style: Theme.of(context).textTheme.subtitle2),
          Container(
              margin: EdgeInsets.only(top: 32),
              child: Icon(
                Icons.event_available,
                size: 64,
                color: secondaryLightGrey,
              ))
        ],
      )),
    );
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: primaryWhite,
        end: accentYellow,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: accentYellow,
        end: primaryWhite,
      ),
    ),
  ]);
}
