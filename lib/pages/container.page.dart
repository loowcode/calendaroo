import 'package:calendaroo/colors.dart';
import 'package:calendaroo/pages/calendar.page.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/fab-button.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarPage(),
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
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: secondaryDarkGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.calendar_today,
                    color: secondaryDarkGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.pie_chart,
                    color: secondaryDarkGrey,
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
    );
  }
}
