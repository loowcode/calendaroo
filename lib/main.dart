import 'package:calendaroo/pages/month.page.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Calendaroo',
        theme: AppTheme.primaryTheme,
        home: MonthPage(),
      ),
    );
  }
}