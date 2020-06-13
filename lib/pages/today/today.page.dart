import 'package:calendaroo/colors.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryWhite,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildTitle(context),
                  IconButton(
                      onPressed: () {
                        NavigationService().navigateTo(SETTINGS);
                      },
                      icon: Icon(Icons.person))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var _formatterDate =
    new DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).today,
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.cloud_off, color: secondaryGrey,),
            )
          ],
        ),
        Text(_formatterDate.format(DateTime.now()), style: Theme.of(context).textTheme.bodyText2,)
      ],
    );
  }
}
