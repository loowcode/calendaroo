import 'package:calendaroo/main.dart';
import 'package:calendaroo/redux/middlewares/app.middlewares.dart';
import 'package:calendaroo/redux/middlewares/calendar.middlewares.dart';
import 'package:calendaroo/redux/reducers/app.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/initializer-app.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() async {
  await setUp();
  var store = createStore();
  initializerAppService.preLoadingData(store);
  runApp(MyApp(store: store));
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferenceService.getSharedPreferencesInstance();
  await sharedPreferenceService.setString('environment', 'develop');
}

Store<AppState> createStore() {
  return Store(appReducer,
      initialState: AppState.initial(),
      middleware: [AppMiddleware(), CalendarMiddleware()]);
}
