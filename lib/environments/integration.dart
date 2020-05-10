import 'package:calendaroo/main.dart';
import 'package:calendaroo/redux/middlewares/app.middlewares.dart';
import 'package:calendaroo/redux/middlewares/calendar.middlewares.dart';
import 'package:calendaroo/redux/reducers/app.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/initializer-app.service.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'environment.dart';

void main() async {
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService().getSharedPreferencesInstance();
  Environment().environment = 'integration';
  InitializerAppService().preLoadingData();
}

