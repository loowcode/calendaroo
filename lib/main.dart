import 'package:calendaroo/pages/month.page.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendaroo',
      theme: AppTheme.primaryTheme,
      home: MonthPage(),
    );
  }
}