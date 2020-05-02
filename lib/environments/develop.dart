import 'package:calendaroo/main.dart';
import 'package:calendaroo/pages/month.page.dart';
import 'package:calendaroo/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'environment.dart';


void main() {
//  SetUp();
  runApp(Develop());
}

class Develop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendaroo',
      theme: AppTheme.primaryTheme,
      home: MonthPage(),
      routes: AppRoutes.routes,
    );
  }
}

//class SetUp extends Environment {
//  final String env = 'dev';
//  final String baseUrl = 'https://example.com';
//  final String firstPage = AppRoutes.MONTH;
//}