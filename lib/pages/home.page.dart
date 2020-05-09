import 'package:calendaroo/colors.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add-event/add-event.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _indexFragmentSelected;

  var _fragmentList = [
    AddEventPage(),
    CalendarWidget(),
    Container(),
    Container()
  ];

  @override
  void initState() {
    super.initState();
    _indexFragmentSelected = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.secondaryTheme,
      child: Scaffold(
        body: Column(
            children: [Expanded(child: CalendarWidget()), _buildBottomBar()]),
//        bottomNavigationBar: BottomNavigationBar(
//          backgroundColor: backgroundWhite,
//          onTap: _onFragmentSelected,
//          items: const <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//                icon: Icon(Icons.add),
//                title: Text('New Event')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.today),
//                title: Text('New Event')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.calendar_today),
//                title: Text('Calendar')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.list),
//                title: Text('Todo')
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.account_circle),
//                title: Text('Profile')
//            ),
//          ],
//          currentIndex: _indexFragmentSelected,
//          unselectedItemColor: secondaryGrey,
//          selectedItemColor: secondaryDarkBlue,
//          showSelectedLabels: true,
//          showUnselectedLabels: true,
//        ),
      ),
    );
  }

  ThemeData _changeTheme(index) {
    if (index == 1) {
      return AppTheme.secondaryTheme;
    } else
      return AppTheme.primaryTheme;
  }

  _onFragmentSelected(int index) {
    setState(() {
      _indexFragmentSelected = index;
    });
  }

  _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(color: backgroundWhite),
      child: SizedBox(
        height: 64,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomIcon(Icons.add, "Add Event", ()=>NavigationService().navigateTo(ADD_EVENT)),
              _buildBottomIcon(Icons.today, AppLocalizations.of(context).translate('today'), ()=> calendarooState.dispatch(SelectDay(DateTime.now()))),
              _buildBottomIcon(Icons.account_circle, "Account", (){}),
            ]),
      ),
    );
  }

  Material _buildBottomIcon(icon, text, onSelect) {
    return Material(
      shape: CircleBorder(),
      color: backgroundWhite, // button color
      child: InkWell(
        radius: 64,
        customBorder: CircleBorder(),
        child: SizedBox(
          height: 64,
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: secondaryGrey,),
              Text(
                text,
                style: Theme.of(context).textTheme.body1.copyWith(color: secondaryGrey),
              )
            ],
          ),
        ),
        onTap: onSelect,
      ),
    );
  }
}
