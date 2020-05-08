import 'package:calendaroo/colors.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/new-event/new-event.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _indexFragmentSelected;

  var _fragmentList = [NewEventWidget(), CalendarWidget(), Container(), Container()];

  @override
  void initState() {
    super.initState();
    _indexFragmentSelected = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _changeTheme(_indexFragmentSelected),
      child: Scaffold(
        body: IndexedStack(
          index: _indexFragmentSelected,
          children: _fragmentList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundWhite,
          onTap: _onFragmentSelected,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('New Event')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text('Calendar')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('Todo')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile')
            ),
          ],
          currentIndex: _indexFragmentSelected,
          unselectedItemColor: secondaryGrey,
          selectedItemColor: secondaryDarkBlue,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  ThemeData _changeTheme(index) {
    if (index==1){
      return AppTheme.secondaryTheme;
    }
    else return AppTheme.primaryTheme;
  }

  _onFragmentSelected(int index) {
    setState(() {
      _indexFragmentSelected = index;
    });
  }
}
