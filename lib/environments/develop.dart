import 'package:calendaroo/main.dart';
import 'package:calendaroo/redux/reducers/app.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  final Store<AppState> store = new Store<AppState>(CalendarReducer.addEvent, initialState: InitialState());
  runApp(MyApp(store: store));
}

Future<Store<AppState>> createStore() async {
  var prefs = await SharedPreferences.getInstance();
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      ValidationMiddleware(),
      LoggingMiddleware.printer(),
      LocalStorageMiddleware(prefs),
      NavigationMiddleware()
    ],
  );
}


//class SetUp extends Environment {
//  final String env = 'dev';
//  final String baseUrl = 'https://example.com';
//  final String firstPage = AppRoutes.MONTH;
//}