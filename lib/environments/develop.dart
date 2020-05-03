import 'package:calendaroo/main.dart';
import 'package:calendaroo/redux/reducers/app.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


void main() {
  var store =  createStore();
  runApp(MyApp(store: store));
}

Store<AppState> createStore()  {
//  var prefs = await SharedPreferences.getInstance();
  return Store(
    appReducer,
    initialState: AppState.initial(),
  );
}


//class SetUp extends Environment {
//  final String env = 'dev';
//  final String baseUrl = 'https://example.com';
//  final String firstPage = AppRoutes.MONTH;
//}