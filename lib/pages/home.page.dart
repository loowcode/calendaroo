import 'package:calendaroo/colors.dart';
import 'package:calendaroo/theme.dart';
import 'package:calendaroo/widgets/calendar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _indexFragmentSelected;

  @override
  void initState() {
    super.initState();
    _indexFragmentSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.secondaryTheme,
      child: Scaffold(
        body: _changeFragment(_indexFragmentSelected),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryWhite,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Todo'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Account'),
            ),
          ],
          currentIndex: _indexFragmentSelected,
          unselectedItemColor: secondaryWhite,
          selectedItemColor: secondaryDarkBlue,
        ),
      ),
    );
  }

  Widget _changeFragment(int index){
    switch(index){
      case 0:
        return CalendarWidget();
      case 1:
        return null;
      case 2:
        return null;
    }
    return null;
  }
}
