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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.secondaryTheme,
      child: Scaffold(
        body: Column(
            children: [Expanded(child: CalendarWidget()), _buildBottomBar()]),
      ),
    );
  }

  _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(color: backgroundWhite),
      child: SizedBox(
        height: 64,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomIcon(Icons.add, AppLocalizations.of(context).addEvent,
                  () => NavigationService().navigateTo(ADD_EVENT)),
              _buildBottomIcon(Icons.today, AppLocalizations.of(context).today,
                  () => calendarooState.dispatch(SelectDay(DateTime.now()))),
              _buildBottomIcon(Icons.settings, AppLocalizations.of(context).settings,
                  () => NavigationService().navigateTo(SETTINGS)),
            ]),
      ),
    );
  }

  Widget _buildBottomIcon(icon, text, onSelect) {
    return Expanded(
      child: Material(
        shape: CircleBorder(),
        color: backgroundWhite, // button color
        child: InkWell(
          customBorder: CircleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: secondaryGrey,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: secondaryGrey),
              )
            ],
          ),
          onTap: onSelect,
        ),
      ),
    );
  }
}
