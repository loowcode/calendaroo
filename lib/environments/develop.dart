import 'package:calendaroo/main.dart';
import 'package:calendaroo/redux/reducers.dart';
import 'package:calendaroo/redux/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() {
  final Store<AppState> store = new Store<AppState>(CalendarReducer.addEvent, initialState: InitialState());
  runApp(MyApp(store: store));
}


//class SetUp extends Environment {
//  final String env = 'dev';
//  final String baseUrl = 'https://example.com';
//  final String firstPage = AppRoutes.MONTH;
//}