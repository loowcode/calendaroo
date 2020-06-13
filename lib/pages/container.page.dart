import 'package:calendaroo/colors.dart';
import 'package:calendaroo/pages/today/today.page.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/fab-button.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/carlinija/Desktop/git/calendaroo/lib/pages/calendar/calendar.page.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with TickerProviderStateMixin {
  int _index;
  List<StatefulWidget> _fragments;

  @override
  void initState() {
    super.initState();
    _fragments = [TodayPage(), CalendarPage()];
    _index = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.primaryTheme,
      child: Scaffold(
        body: _fragments[_index],
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FabButton(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              margin: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    //update the bottom app bar view each time an item is clicked
                    onPressed: () {
                      setState(() {
                        _index = 0;
                      });
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.home,
                      //darken the icon if it is selected or else give it a different color
                      color: _index == 0 ? secondaryBlue : secondaryGrey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.calendar_today,
                      color: _index == 1 ? secondaryBlue : secondaryGrey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.pie_chart,
                      color: _index == 2 ? secondaryBlue : secondaryGrey,
                    ),
                  ),
                  //to leave space in between the bottom app bar items and below the FAB
                  SizedBox(
                    width: 50.0,
                  ),
                ],
              )),
          shape: CircularNotchedRectangle(),
          color: primaryWhite,
        ),
      ),
    );
  }
}
