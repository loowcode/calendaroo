import 'package:calendaroo/pages/month.page.dart';
import 'package:calendaroo/routes.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

void main() => runApp(Develop());

class Develop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendaroo',
      theme: AppTheme.primaryTheme,
      home: MonthPage(),
      routes: appRoutes,
    );
  }
}